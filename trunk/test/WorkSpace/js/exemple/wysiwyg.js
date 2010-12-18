    function load(){
      getIFrameDocument("edit").designMode = "On";
      document.getElementById('edit').contentWindow.focus();
    }

    function getIFrameDocument(aID){
      if (document.getElementById(aID).contentDocument){
        return document.getElementById(aID).contentDocument;
      } else {
        return document.frames[aID].document;
       }
     }

    function EditCommand(cNom,cArg){
	  document.getElementById('edit').contentWindow.focus();
      getIFrameDocument('edit').execCommand(cNom, false, cArg);
      document.getElementById('edit').contentWindow.focus();
    }

    function ajouterlien(){
	  document.getElementById('edit').contentWindow.focus();
      if (navigator.appName!="Microsoft Internet Explorer")
      {
      var myUrl = prompt("Entrez l\'adresse du lien :", "");
      getIFrameDocument("edit").execCommand("createLink", false, myUrl);
      } else {
      getIFrameDocument("edit").execCommand("createLink", true);
      }
      document.getElementById('edit').contentWindow.focus();
    }

   function ajouterimage(){
      document.getElementById('edit').contentWindow.focus();
      var myUrl = prompt("Entrez l\'adresse de l'image :", "http://");
      if (myUrl != 'http://' && myUrl != '' && myUrl !=null){
      getIFrameDocument("edit").execCommand("insertimage", false, myUrl);
      document.getElementById('edit').contentWindow.focus();
      }
    }

   	function smiley (smile) {
      document.getElementById('edit').contentWindow.focus();
      getIFrameDocument("edit").execCommand("insertimage", false, smile);
      if (navigator.appName=="Microsoft Internet Explorer"){
	  var range = getIFrameDocument("edit").body.createTextRange();
      range.moveStart('character', '256');
      range.select();
	  }
	}

    function getSource(){
		document.getElementById('source').value = getIFrameDocument("edit").body.innerHTML;
    	}