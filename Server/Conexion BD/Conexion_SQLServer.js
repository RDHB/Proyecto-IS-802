var sql = require("mssql");
var config = require("./Config");
var conn = new sql.ConnectionPool(config.dbConfig);
module.exports = conn




 