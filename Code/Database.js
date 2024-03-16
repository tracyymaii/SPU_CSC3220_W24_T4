function dbInit()
{
    let db = LocalStorage.openDatabaseSync("Water_Tracker_DB", "", "Track water intake", 1000000)
    try {
        db.transaction(function (tx) {
            // tx.executeSql("DROP TABLE users_info")  // uncomment line to reset user data
            tx.executeSql('CREATE TABLE IF NOT EXISTS water_log (date text, amount numeric, happiness numeric)')
            tx.executeSql('CREATE TABLE IF NOT EXISTS users_info (uid numeric PRIMARY KEY, pname text, uname text, notifon integer)')
            tx.executeSql("INSERT OR IGNORE INTO users_info VALUES (0, 'your_pet', 'your_name', 0)")
        })
    } catch (err) {
        console.log("Error creating table in database: " + err)
    };
}

function dbGetUserInfo(uid) {
    let db = dbGetHandle()
    let res = {}
    db.transaction((tx) => {
        let result = tx.executeSql("SELECT * FROM users_info WHERE uid = ?", [uid]).rows.item(0)
        res.uname = result.uname
        res.pname = result.pname
        res.notifs = result.notifon
    })
    return res
}

function dbWriteUserInfo(uid, uname, pname, notifsOn) {
    let db = dbGetHandle()
    db.transaction((tx) => {
        tx.executeSql("UPDATE users_info SET uname = ?, pname = ?, notifon = ? WHERE uid = ?",
                      [uname, pname, notifsOn, uid])
    })
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
    let happiness = 0.5
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
    let happiness = 0.5
    db.transaction(function (tx) {
        let result = tx.executeSql(
                'SELECT * FROM water_log WHERE date=?', [Pdate])
        if (result.rows.length !== 0){
            happiness = result.rows.item(0).happiness
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
                'SELECT * FROM water_log WHERE date=?', [Pdate])
        if (result.rows.length !== 0){
            amount = result.rows.item(0).amount
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
                                 amount: results.rows.item(i).amount
                             })
        }
    })
}

function dbUpdate(Pdate, Pamount, Phappiness)
{
    let db = dbGetHandle()
    let happy = 0.5
    db.transaction(function (tx) {
        happy = dbReadHappiness(Pdate) + Phappiness
        if (happy > 1.0){
            happy = 1.0
        }
        tx.executeSql(
                    'update water_log set amount=?, happiness=? where date=?', [Pamount, happy, Pdate])
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
