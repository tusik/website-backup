#!/bin/bash
#数据库用户
SQLUSER="root"
#数据库密码
SQLPW="passwd"
#数据库名，空格隔开
DATABASE="database"
webfile="`date +%y%m%d%I%M`_web_backup.tar.gz"
sqlfile="`date +%y%m%d%I%M`_sql_backup.tar.gz"
backupfile="`date +%y%m%d%I%M`_backup.tar"
tmpdir="`date +%y%m%d%I%M`_backup"
mkdir ${tmpdir} ${tmpdir}/sql
tar -zcvf ${tmpdir}/${webfile} /home/wwwroot
for name in ${DATABASE}
    do
        sqlname=${name}".sql"
        mysqldump -uroot -p${SQLPW} ${name} > ${tmpdir}/sql/${sqlname}
    done
tar -zcvf ${tmpdir}/${sqlfile} ${tmpdir}/sql/*.sql
tar -cvf ${backupfile} ${tmpdir}/*.tar.gz
rm -rf ${tmpdir}
#上传备份文件到其他vps上 -l 为scp限速，单位kb/s
scp -l 1000 ${backupfile} root@hostname:/home/backupdir