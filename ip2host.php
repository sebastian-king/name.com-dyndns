<?php
require("namecom.php");
$api = new NameComApi();
$api->login('NAME_COM_API_USERNAME', 'NAME_COM_API_KEY');

$sub_domain = $_GET['sub_domain'];
$super_domain = $_GET['super_domain'];
$ip = ((@$_GET['ip']) ? $_GET['ip'] : $_SERVER['REMOTE_ADDR']);

$response = $api->get_domain($super_domain);
if ($response->result->code != 100) {
        $a = array("response"=>"You probably don't own the domain.","code"=>$response->result->code);
}

$response = $api->list_dns_records($super_domain);
if ($response->result->code != 100) {
        $a = array("response"=>"An unknown error has occured when querying the superdomain.","code"=>$response->result->code);
}
foreach ($response->records as $key => $val) {
        if ($val->name == $sub_domain.".".$super_domain) { // delete entry
                $_response = $api->delete_dns_record($super_domain, $val->record_id);
                if ($_response->result->code != 100) {
                        $a = array("response"=>"An unknown error has occured when deleting the old entry.","code"=>$_response->result->code);
                }
        }
}
$response = $api->create_dns_record($super_domain, $sub_domain, 'A', $ip, 300);
if ($response->result->code != 100) {
        $a = array("response"=>"An unknown error has occured when updating the record.","code"=>$response->result->code);
} else {
        $a = array("response"=>"IP updated successfully.","code"=>$response->result->code);
}
$api->logout();
?>
