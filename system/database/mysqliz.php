
<?php
final class MySQLiz {
private $connection;
private $connected;

public function __construct($hostname, $username, $password, $database, $port = '3306') {
try {
//mysqli_report(MYSQLI_REPORT_STRICT);

$this->connection = @new \mysqli($hostname, $username, $password, $database, $port);
} catch (\mysqli_sql_exception $e) {
//throw new \Exception('Error: Could not make a database link using ' . $username . '@' . $hostname . '!');
throw new \Exception('Could not make a database link  Mysql Error: <br />' );
}

$this->connection->set_charset("utf8");
$this->connection->query("SET SQL_MODE = ''");
}

public function query($sql) {

//ahmad system/logs/ahmad_SQL_log.txt, to develop check every php module
/*
$logfile = DIR_LOGS."ahmad_SQL_log.txt";
$starttime  = microtime(true);
*/
//this code use to empty the log
//file_put_contents("filelist.txt", "");
//var_dump($logfile);


$query = $this->connection->query($sql);

if (!$this->connection->errno) {
if ($query instanceof \mysqli_result) {
$data = array();

while ($row = $query->fetch_assoc()) {
$data[] = $row;
}

$result = new \stdClass();
$result->num_rows = $query->num_rows;
$result->row = isset($data[0]) ? $data[0] : array();
$result->rows = $data;

$query->close();


//ahmad system/logs/ahmad_SQL_log.txt
/*
$endtime  = microtime(true);
if(($endtime-$starttime) > 0.04){

echo sprintf(date("Y-m-d H:i:s",time())." QUERY EXECUTED IN %0.4f - %s", $endtime-$starttime, $sql);
}
if( ($endtime-$starttime) > 0.5){


$log = sprintf(date("Y-m-d H:i:s",time())." QUERY EXECUTED IN %0.4f - %s", $endtime-$starttime, $sql);

if(!file_exists($logfile)) { file_put_contents($logfile,''); }

$f = fopen($logfile, 'a');
fwrite($f, $log."\n");

fclose($f);
} */
//end ahmad ismail log

return $result;
} else {
return true;
}
} else {
throw new \Exception('Mysql Error: ' . $this->connection->error  . '<br />Error No: ' . $this->connection->errno . '<br />' . $sql);
//throw new \Exception('Mysql Error: <br />' . $sql);
}
}

public function escape($value) {
return $this->connection->real_escape_string($value);
}

public function countAffected() {
return $this->connection->affected_rows;
}

public function getLastId() {
return $this->connection->insert_id;
}

public function isConnected() {
return $this->connection->ping();
}

public function __destruct() {
if (!$this->connection) {
$this->connection->close();
}
}
}