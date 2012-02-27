/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function preview(id){
    var NEW_WIN2 = null;
    NEW_WIN2 = window.open ("", "preview","toolbar=no,width=480,height=300,ScreenX="+((window.innerWidth-480)/2)+",screenY="+((screen.height-300)/2)+",directories=no,status=no,scrollbars=no,resizable=0,menubar=no");
    NEW_WIN2.location.href = "http://localhost:3000/stores/video_show?id="+id;
    NEW_WIN2.focus();
    return false;
}

