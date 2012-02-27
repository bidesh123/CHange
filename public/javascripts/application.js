// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function AddImages(el){

    //    $j(el).remove();
    // ajax request, rjs runs javascript to load partials
    $j.get('/stores/add_images', null, null, 'script');
}

function AddVideos(el){

    //    $j(el).remove();
    // ajax request, rjs runs javascript to load partials
    $j.get('/stores/add_videos', null, null, 'script');
}


function AddOtherImages(el){
    $j.get('/other_videos/add_images', null, null, 'script');
}

function AddContent(el){
    $j(el).remove();
    $j.get('/stores/add_content', null, null, 'script');
}
function RemoveImage(el){
    
}


function mon(varid)
{
    document.getElementById('play_'+varid).style.display='block';
    document.getElementById('img_'+varid).style.margin='0px';
    document.getElementById('img_'+varid).style.border='2px solid #9f210f';
}

function moff(varid)
{
    document.getElementById('play_'+varid).style.display='none';
    document.getElementById('img_'+varid).style.margin='2px';
    document.getElementById('img_'+varid).style.border='none';
}

