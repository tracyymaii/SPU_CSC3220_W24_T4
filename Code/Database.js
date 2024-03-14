function dbInit()
{
    let db = LocalStorage.openDatabaseSync("Water_Tracker_DB", "", "Track water intake", 1000000)
    try {
        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS water_log (date text, amount numeric DEFAULT 0.0, happiness numeric DEFAULT 0.7)')
        })
    } catch (err) {
        console.log("Error creating table in database: " + err)
    };
}

function dbGetHandle()
{
    try {
        var db = LocalStorage.openDatabaseSync("Water_Tracker_DB", "",
                                               "Track water intake", 1000000)
    } catch (err) {
        console.log("Error opening database: " + err)
    }
    return db
}

function dbInsert(Pdate, Pamount, Phappiness)
{
    let db = dbGetHandle()
    let rowid = 0;
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO water_log VALUES(?, ?, ?)',
                      [Pdate, Pamount, Phappiness])
        let result = tx.executeSql('SELECT last_insert_rowid()')
        rowid = result.insertId
    })
    return rowid;
}

function dbReadAll()
{
    let db = dbGetHandle()
    db.transaction(function (tx) {
        let results = tx.executeSql(
                'SELECT rowid,date,amount FROM water_log order by rowid desc')
        for (let i = 0; i < results.rows.length; i++) {
            listModel.append({
                                 id: results.rows.item(i).rowid,
                                 checked: " ",
                                 date: results.rows.item(i).date,
                                 amount: results.rows.item(i).amount,
                                 happiness: result.rows.item(i).happiness
                             })
        }
    })
}

function dbUpdate(Pdate, Pamount, Prowid, Phappiness)
{
    let db = dbGetHandle()
    db.transaction(function (tx) {
        tx.executeSql(
                    'update water_log set date=?, amount=?, happiness=? where rowid = ?', [Pdate, Pamount, Phappiness, Prowid])
    })
}
/*
function dbDeleteRow(Prowid)
{
    let db = dbGetHandle()
    db.transaction(function (tx) {
        tx.executeSql('delete from water_log where rowid = ?', [Prowid])
    })
}*/
