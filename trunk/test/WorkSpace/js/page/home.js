/**
 * Redimension des listes de taches à faire et resolu
 */
function setH()
{
	if (document.documentElement && document.documentElement.clientHeight)
		HT=document.documentElement.clientHeight;
	else
		HT=document.body.clientHeight;

	// Tableau ToDo
	obj=document.getElementById('theTableToDo')
	tabHT=(Math.max(obj.offsetHeight,HT)-obj.offsetTop-15)/2;
	document.getElementById('theCellToDo').style.height=tabHT+'px';
	document.getElementById('theCellResolved').style.height=tabHT+'px';
}
// Initialisation des evenements de la page
onload=setH;
onresize=setH;