rp = rp or {}
rp.db = rp.db or {}
rp.db.prefix = rp.db.prefix or "rp"
rp.db.usersIndex = rp.db.usersIndex or rp.db.prefix .. "_users"

rp.print('Processing..', 'roleplay/sql ~ #', nil, 'warn')

if (not sql.IndexExists(rp.db.usersIndex)) then
    sql.Query("CREATE TABLE" .. rp.db.usersIndex .. "( id NUMBER , rpname TEXT, money INTEGER )" )
end

rp.print('Processed', 'roleplay/sql ~ #', nil, 'warn')
