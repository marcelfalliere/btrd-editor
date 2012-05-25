
$(document).ready(function() {
if ($("#iphone").length==1) {

	// some dom
	var $iphone = $("#iphone");
	var $screen = $("#iphone #screen");
	var $case = $("#iphone #case");
	var $coordinates = $("#editbox #coordonnees");
	var $details = $("#editbox #details");
	var $fastedit = $("#fastedit");
	var $fastedit_begin = $("#fastedit").find("#beginfastedit");
	var $fastedit_actions = $("#fastedit-actions");
	var $fastedit_select = $fastedit.find("select");
	var $fastedit_coordinates = $fastedit.find("#coordinates");
	
	// some data
	var caseInitialTop = $case.position().top;
	var caseInitialLeft = $case.position().left;
	var x=1;
	var y=1;
	var niveau_id=$("#niveau_id").val();
	var fastedit_in_action=false;
	
	/**
	 * Coordonnées et suivi des cases avec un boite rouge 
	 */
	$screen.mousemove(function(e) {
		x = Math.ceil((e.pageX - $screen.offset().left)/16);
		y = Math.ceil((480-(e.pageY - $screen.offset().top))/16);
		$coordinates.html(x+" - "+y);
		$case.css("top", caseInitialTop+ (30-y)*16  ).css("left", caseInitialLeft+((x-1)*16));
	});
	
	/**
	 * Soumission du formulaire spécifique à une case
	 */
	 $details.delegate("form","submit", function(){
	 	$form=$(this).closest("form");
		$.post(
			$form.attr("action"),
			$form.serialize(),
			function(data){
				$details.html(data);
				$screen.load("/niveaus/"+niveau_id+"/screen");
			});
		return false;
	 })

	/**
	 * Click sur une case, en mode fastedit ou non
	 */
	$case.click(function() {
		if (!fastedit_in_action) {
			$details.load("/elements/details/?x="+x+"&y="+y+"&niveauId="+niveau_id+"");
		} else {
			var selectedType=$fastedit_select.val();
			var cssLeft=((x-1)*16);
			var cssTop=(480-(y*16));
			
			if (selectedType=="delete") {
				$screen.children(".case").each(function(i,o) {
					if ($(o).css("left")==(cssLeft+"px") && $(o).css("top")==(cssTop+"px")) {
						$(o).remove();
					}
				});
			} else {
				cssClass="";
				$fastedit_select.children("option").each(function(i,o){
					if (selectedType==$(o).attr("value")) {
						cssClass=$(o).attr("data-cssClass");
					}
				});
				$screen.append("<div class='case "+cssClass+"' style='left:"+cssLeft+"px;top:"+cssTop+"px;width:16px;height:16px'></div>");					
			}
			valeurActuelle=$fastedit_coordinates.val();
			$fastedit_coordinates.val(valeurActuelle+"["+x+","+y+"];");
		}
	});
	
	/**
	 * Entrer en mode fast edit
	 */
	$fastedit_begin.click(function() {
		fastedit_in_action=true;
		$details.hide();
		$fastedit_begin.hide();
		$fastedit_actions.show();
		$fastedit.find("#feedback").hide();
		return false;
	});

	/**
	 * Annuler le fast edit
	 */
	$fastedit_actions.find("#annulerfastedit").click(function() {
		fastedit_in_action=false;
		$fastedit_actions.hide();
		$details.show();
		$fastedit_coordinates.val("");
		$screen.load("/niveaus/"+niveau_id+"/screen", function(data) { $fastedit_begin.show(); } );
		return false;
	});

	/**
	 * Validation du mode fast edit
	 */
	$fastedit_actions.find("input[type=submit]").click(function() {
		$form=$fastedit.find("form");
		$.post(
			$form.attr("action"),
			$form.serialize(),
			function(data){
				$fastedit.find("#feedback").show();
				$fastedit.find("#feedback").html(data);
				$screen.load("/niveaus/"+niveau_id+"/screen", function(data) {  $fastedit_begin.show();  });
				fastedit_in_action=false;
			});
		
		$fastedit_coordinates.val("");
		$details.html("");
		$details.show();
		$fastedit_begin.show();
		$fastedit_actions.hide();
		return false;
	});
	
}
});



