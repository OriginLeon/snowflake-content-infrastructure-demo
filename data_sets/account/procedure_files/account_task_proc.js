let step = "merging the UPDATE data";

try {

    snowflake.execute({sqlText: 'BEGIN WORK;'});

    // FAZ O MERGE DE FORMA A PEGAR SEMPRE O DADO MAIS RECENTE DO TIPO "INSERT" OU "UPDATE" DE CADA ACCOUNT
    snowflake.execute({
        sqlText: `
         MERGE INTO ${PROC_ACCOUNT_TABLE} AS acct
          USING
          (
            SELECT ID, JSON, EVENT_UPDATE FROM (
              SELECT row_number() over (partition by str.ID order by str.JSON:data:attributes:updatedAt::datetime desc) as row_number,
              str.ID, str.JSON, str.JSON:data:attributes:updatedAt::datetime as EVENT_UPDATE
              FROM ${PROC_ACCOUNT_STREAM} str
              WHERE str.TYPE in ('INSERT', 'UPDATE')
            )
            WHERE row_number = 1
          ) AS filteredStr
          ON acct.ID = filteredStr.ID
          WHEN MATCHED THEN
          UPDATE set JSON=filteredStr.JSON, RECORD_UPDATE=filteredStr.EVENT_UPDATE // ATUALIZA O JSON E A DATA SE FOR UMA ATUALIZAÇÃO
          WHEN NOT MATCHED THEN
          INSERT (ID, JSON, RECORD_UPDATE, DELETED_TIMESTAMP) // SIMPLESMENTE ADICIONA O DADO SE ELE AINDA NÃO EXISTE NA TABELA DESTINO
          values (filteredStr.ID, filteredStr.JSON, filteredStr.EVENT_UPDATE, null);
    `});

    step = "merging the DELETE data";

    // FAZ O MERGE DE FORMA A FAZER A REMOÇÃO LÓGICA DA ACCOUNT PARA EVENTOS DO TIPO "DELETE"
    snowflake.execute({
        sqlText: `
          MERGE INTO ${PROC_ACCOUNT_TABLE} acct USING
          (
            SELECT ID, EVENT_UPDATE FROM (
              SELECT row_number() over (partition by str.ID order by str.EVENT_UPDATE desc) as row_number,
              str.ID, str.EVENT_UPDATE
              FROM ${PROC_ACCOUNT_STREAM} str
              WHERE str.TYPE LIKE 'DELETE'
            )
            WHERE row_number = 1
          ) AS filteredStr
          ON acct.ID = filteredStr.ID
          WHEN MATCHED THEN
          UPDATE set DELETED_TIMESTAMP=CURRENT_TIMESTAMP
          WHEN NOT MATCHED THEN
          INSERT (ID, JSON, RECORD_UPDATE, DELETED_TIMESTAMP) // AS VEZES POSSO RECEBER DIRETO A REMOÇÃO DE UMA CONTA QUE NEM FIZ A INSERÇÃO AINDA, DAI RECORDO O HISTORICO
          values (filteredStr.ID, null, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
    `});

    step = "committing work";

    snowflake.execute({sqlText: 'COMMIT WORK;'});

    return "OK";

} catch (err) {
    snowflake.execute({ sqlText: 'ROLLBACK WORK;' })

    const arguments = {
      "step" : step,
      "account_table param" : PROC_ACCOUNT_TABLE,
      "account_stream param" : PROC_ACCOUNT_STREAM
    };

    /* EXEMPLO DE CHAMADA DE UMA PROCEDURE CRIADA PARA PROCESSAMENTO DE ERROS
    var result = snowflake.createStatement({
        sqlText: 'CALL DEMO_DB.PUBLIC.PROCEDURE_ERROR_PROCESSING(:1, :2, :3);',
        binds: ['ACCOUNT_TASK_PROC',
          JSON.stringify(arguments),
          err.message]
    }).execute();
    */

    return err;
}
