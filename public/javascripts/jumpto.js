function jumpTo(anchor) {
  // Find the <a name> tag corresponding to this href
  var allLinks = document.getElementsByTagName('a');
  var destinationLink = null;
  for (var i=0;i<allLinks.length;i++) {
    var lnk = allLinks[i];
    if (lnk.name && (lnk.name == anchor)) {
      destinationLink = lnk;
      break;
    }
  }

  // If we didn't find a destination, give up and let the browser do
  // its thing
  if (!destinationLink) return true;
  // Find the destination's position
  var desty = destinationLink.offsetTop;
  var thisNode = destinationLink;
  while (thisNode.offsetParent &&
      (thisNode.offsetParent != document.body)) {
    thisNode = thisNode.offsetParent;
    desty += thisNode.offsetTop;
  }
  window.scrollTo(0,desty);
}
