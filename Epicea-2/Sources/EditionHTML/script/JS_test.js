/*SCROLL BAR ROLLOVER*/
function scrolling(){
couleurligne = "#000000";
couleurbase = "#336666";
couleurover = "#FFCC66";
couleurfleche = "#FF8800";
function scrollBar(face)
{
with(document.body.style)
{
scrollbarDarkShadowColor=couleurligne;
scrollbar3dLightColor=couleurligne;
scrollbarArrowColor=couleurfleche;
scrollbarBaseColor=face;
scrollbarFaceColor=face;
scrollbarHighlightColor=face;
scrollbarShadowColor=face;
scrollbarTrackColor="#FF8800";
}
}
function colorBar(){
var w = document.body.clientWidth;
var h = document.body.clientHeight;
var x = event.clientX;
var y = event.clientY;
if(x>w) scrollBar(couleurover);
else scrollBar(couleurbase);
}
if (document.all){
scrollBar(couleurbase);
document.onmousemove=colorBar;
}
}
/*GENERATION DE TABLEAUX*/
function tableau(){ 
function touslestitres(Titre){ 
Titre = new Array();
Titre1.value = Titre[0];
Champ1.value = Titre[1];
Champ2.value = Titre[2];
for(Titre=0; Titre>Titre[0]; Titre++){
//document.write(Titre);
}
}
style =  maclasse;
ok = (Titre.length);
 result = ok;
 nombre_TD = result;
   for (numTD = 0 ; numTD < nombre_TD; numTD++) {
   //ici je verifie si la cellule contient qqchose
   if((Titre[numTD])==""){
     document.write("<td bgcolor=\"FFCC66\" background=\"../images/pattern.gif\"><i><font face=\"Verdana, Arial, Helvetica, sans-serif\" size=\"1\" color=\"#666666\">N�ant</font></i></td>");
   }
   else {
   document.write("<td class="+style+">"+Titre[numTD]+"</td>");
	 }
	  }
document.write("</tr>");
}