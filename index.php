<?php
$connect_DB=mysqli_connect('127.0.0.1','hw3','410785056','hw3');

if($connect_DB)
{
	//echo '連線成功';
}
else
{
	echo '連線失敗';
	exit();
}

$flag=mysqli_select_db($connect_DB,'hw3');
if($flag)
{
	//echo '資料庫可用';
}
else
{
	echo '資料庫不可用';
	exit();
}
mysqli_query($connect_DB,"SET NAMES 'utf-8'");


//使用者table
$result=mysqli_query($connect_DB,"select * from `user` WHERE id='410785056'");
$result_sec=[];
while($row=mysqli_fetch_array($result,MYSQLI_NUM)){
	$result_sec[]=$row;
}
print '<table border=1>';
print '<tr>';
print '<th>id</th>';//user id
print '<th>name</th>';//user name
print '</tr>';
foreach ($result_sec as $key => $value) {
	print '<tr>';
	print '<td>'.$value[0].'</td>';//user id
	print '<td>'.$value[1].'</td>';//user name
	print '</tr>';
}
print '</table>';
print '<br>';

//列出5月收入
$income=mysqli_query($connect_DB,"SELECT * ,active_income+passive_income as total_income FROM `income` WHERE y_m like '2021-05%'");
$income_sec=[];
while($row=mysqli_fetch_array($income,MYSQLI_NUM)){
	$income_sec[]=$row;
}
$total_income=0;
print '<table border=1>';
print '<tr>';
print '<th>id</th>';//user id
print '<th>year-month</th>';//year month
print '<th>active income</th>';//user active income
print '<th>passive income</th>';//user passive income
print '<th>total income</th>';//user total income
print '</tr>';
foreach ($income_sec as $key => $value) {
	$total_income=$value[4];
	print '<tr>';
	print '<td>'.$value[0].'</td>';//user id
	print '<td>'.$value[1].'</td>';//year month
	print '<td>'.$value[2].'</td>';//user active income
	print '<td>'.$value[3].'</td>';//user passive income
	print '<td>'.$value[4].'</td>';//user total income
	print '</tr>';
}
print '</table>';
print '<br>';

//列出2021-05-01的所有花費
$expenses=mysqli_query($connect_DB,"SELECT * FROM `living expenses` WHERE date='2021-05-01'");
$expenses_sec=[];
while($row=mysqli_fetch_array($expenses,MYSQLI_NUM)){
	$expenses_sec[]=$row;
}

print "2021-05-01的花費";
print '<table border=1>';
print '<tr>';
print '<th>id</th>';//user id
print '<th>date</th>';//date
print '<th>item</th>';//item
print '<th>species</th>';//species
print '<th>cost</th>';//cost
print '<th>remark</th>';//remark
print '</tr>';
foreach ($expenses_sec as $key => $value) {
	print '<tr>';
	print '<td>'.$value[0].'</td>';//user id
	print '<td>'.$value[1].'</td>';//date
	print '<td>'.$value[2].'</td>';//item
	print '<td>'.$value[3].'</td>';//species
	print '<td>'.$value[4].'</td>';//cost
	print '<td>'.$value[5].'</td>';//remark
	print '</tr>';
}
print '</table>';
print '<br>';

//5月總花費
$total_cost=0;
$cost=mysqli_query($connect_DB,"SELECT user_id,SUM(cost) as total_cost FROM `living expenses`");
$cost_sec=[];
while($row=mysqli_fetch_array($cost,MYSQLI_NUM)){
	$cost_sec[]=$row;
}
print '<table border=1>';
print '<tr>';
print '<th>id</th>';//user id
print '<th>total cost</th>';//total cost
print '</tr>';
foreach ($cost_sec as $key => $value) {
	$total_cost=$value[1];
	print '<tr>';
	print '<td>'.$value[0].'</td>';//user id
	print '<td>'.$value[1].'</td>';//total cost
	print '</tr>';
}
print '</table>';
print '<br>';

//使用者的股票table
$stock_earn=0;//股票賺的錢
$stock=mysqli_query($connect_DB,"SELECT * FROM `stock`");
$stock_sec=[];
while($row=mysqli_fetch_array($stock,MYSQLI_NUM)){
	$stock_sec[]=$row;
}
print '<table border=1>';
print '<tr>';
print '<th>buyer id</th>';
print '<th>股票名稱</th>';
print '<th>股數</th>';
print '<th>買進股價</th>';
print '<th>賣出股價</th>';
print '</tr>';
foreach ($stock_sec as $key => $value) {
	$num=$value[2];
	$purchase=$value[3];
	$sell=$value[4];
	$stock_earn+=$num*($sell-$purchase);
	print '<tr>';
	print '<td>'.$value[0].'</td>';//user id
	print '<td>'.$value[1].'</td>';//company name
	print '<td>'.$num.'</td>';//number of shares
	print '<td>'.$purchase.'</td>';//purchase share price

	//sell share price
	if($sell>$purchase){
		print '<td><font color="#FF0000">'.$sell.'</font></td>';
	}else if ($sell<$purchase) {
		print '<td><font color="#00DB00">'.$sell.'</font></td>';
	}else{
		print '<td>'.$sell.'</td>';
	}
	

	print '</tr>';
}
print '</table>';
print '<br>';

if($stock_earn>=0){
	print "股票賺了".$stock_earn."元";
}else{
	print "股票賠了".$stock_earn."元";
}
print '<br>';



$save_money=$total_income-$total_cost;
print "5月剩餘金額:".$save_money."元(不含股票)";

/*	
if (!empty($_SERVER['HTTPS']) && ('on' == $_SERVER['HTTPS'])) {
	$uri = 'https://';
} else {
	$uri = 'http://';
}
$uri .= $_SERVER['HTTP_HOST'];
header('Location: '.$uri.'/dashboard/');
exit;
*/	
?>

