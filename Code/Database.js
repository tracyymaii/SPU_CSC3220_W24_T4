function dbInit()
{
    let db = LocalStorage.openDatabaseSync("Water_Tracker_DB", "", "Track water intake", 1000000)
    try {
        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS water_log (date text, amount numeric, happiness numeric)')
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

function dbInsertDate(Pdate)
{
    let db = dbGetHandle()
    let happiness = 0.7
    db.transaction(function (tx) {
        let result = tx.executeSql('SELECT date,amount FROM water_log WHERE date=?',
                [Pdate])
        let idresult = tx.executeSql('SELECT last_insert_rowid()')
        let happyresult = tx.executeSql('SELECT happiness FROM water_log WHERE rowid=?', [idresult.insertId])
        if (happyresult.rows.length !== 0){
            happiness = rate.rows.item(0).happiness
        }
        if (result.rows.length === 0){
            dbInsert(Pdate, 0.0, happiness)
        }
    })
}

function dbReadHappiness(Pdate)
{
    let db = dbGetHandle()
    let happiness = 0.7
    db.transaction(function (tx) {
        let result = tx.executeSql(
                'SELECT happiness FROM water_log WHERE date=?', [Pdate])
        if (result.rows.length === 0){
            happiness = result.row.item(0).happiness
        }
    })
    return happiness
}

function dbReadAmount(Pdate)
{
    let db = dbGetHandle()
    let amount = 0.0
    db.transaction(function (tx) {
        let result = tx.executeSql(
                'SELECT amount FROM water_log WHERE date=?', [Pdate])
        if (result.rows.length === 0){
            amount = result.row.item(0).amount
        }
    })
    return amount
}

function dbReadAll()
{
    let db = dbGetHandle()
    db.transaction(function (tx) {
        let results = tx.executeSql(
                'SELECT date,amount FROM water_log order by date desc')
        for (let i = 0; i < results.rows.length; i++) {
            listModel.append({
                                 date: results.rows.item(i).date,
                                 checked: " ",
                                 amount: results.rows.item(i).amount,
                                 happiness: results.rows.item(i).happiness
                             })
        }
    })
}

function dbUpdate(Pdate, Pamount, Phappiness)
{
    let db = dbGetHandle()
    db.transaction(function (tx) {
        tx.executeSql(
                    'update water_log set amount=?, happiness=? where date=?', [Pamount, Phappiness, Pdate])
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
