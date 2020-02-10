var Request = require('tedious').Request;
var connection = require('./connect');
var utility = require('./utility/utility');
function spGetExecute(qry, callback) {
    var data = [];
    var dataset = [];
    var resultset = 0;
    request = new Request(qry, function (err, rowCount) {
        utility.sendDbResponse(err, rowCount, dataset, callback);
});
request.on('row', function (columns) {
        utility.buildRow(columns, data);
});
request.on('doneInProc', function (rowCount, more, rows) {
        dataset.push(data);
        data = [];
    });
connection.callProcedure(request);
}
module.exports = {
    get: spGetExecute 
};
