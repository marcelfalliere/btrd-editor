$(document).ready(function() {
if ($("#iphone").length==1) {

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
	
	var caseInitialTop = $case.position().top;
	var caseInitialLeft = $case.position().left;
	
	var x=1;
	var y=1;
	var niveau_id=$("#niveau_id").val();
	var fastedit_in_action=false;
	
	// initialisation de l'écran
	$fastedit_actions.hide();
	$fastedit_actions.find("#feedback").hide();
	
	// coordinates
	$screen.mousemove(function(e) {
		x = Math.ceil((e.pageX - $screen.offset().left)/16);
		y = Math.ceil((480-(e.pageY - $screen.offset().top))/16);
		$coordinates.html(x+" - "+y);
		
		$case.css("top", caseInitialTop+ (30-y)*16  );
		$case.css("left", caseInitialLeft+((x-1)*16));
	});
	
	// clic sur une case
	$case.click(function() {
		if (!fastedit_in_action) {
			url="/elements/details/?x="+x+"&y="+y+"&niveauId="+niveau_id+""
			$details.load(url,function() {
			
					
					$details.find("input[type=submit]").click(function(){
						$form=$(this).closest("form");
						$.post(
							$form.attr("action"),
							$form.serialize(),
							function(data){
								$details.html(data);
								
								urlReloadScreen="/niveaus/"+niveau_id+"/screen";
								$screen.load(urlReloadScreen);
							});
						return false;
					});
			});
		} else {
			// classe css du type choisi ?
			selectedType=$fastedit_select.val();
			cssLeft=((x-1)*16);
			cssTop=(480-(y*16));
			if (selectedType=="delete") {
				// trouver la case avec les propriétés css left et top
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
				
				// créer un div du type
				$screen.append("<div class='case "+cssClass+"' style='left:"+cssLeft+"px;top:"+cssTop+"px;width:16px;height:16px'></div>");
								
			}
			// ajouter au hidden pour le formulaire
			valeurActuelle=$fastedit_coordinates.val();
			$fastedit_coordinates.val(valeurActuelle+"["+x+","+y+"];");
		}
	});
	
	$fastedit_begin.click(function() {
		fastedit_in_action=true;
		
		$details.hide();
		$fastedit_begin.hide();
		$fastedit_actions.show();
		$fastedit.find("#feedback").hide();
		
		$fastedit_actions.find("#annulerfastedit").click(function() {
			$fastedit_actions.hide();
			//reload screen
			urlReloadScreen="/niveaus/"+niveau_id+"/screen";
			$screen.load(urlReloadScreen, 
				function(data) {  $fastedit_begin.show(); }
			);
			
			$fastedit_coordinates.val("");
			$details.hide();
			fastedit_in_action=false;
			return false;
		});
		
		$fastedit_actions.find("input[type=submit]").click(function() {
			
			$form=$fastedit.find("form");
			$.post(
				$form.attr("action"),
				$form.serialize(),
				function(data){
					$fastedit.find("#feedback").show();
					$fastedit.find("#feedback").html(data);
					
					urlReloadScreen="/niveaus/"+niveau_id+"/screen";
					$screen.load(urlReloadScreen, function(data) { 
						$fastedit_begin.show();
					});
				});
			
			$fastedit_coordinates.val("");
			$details.html("");
			$details.show();
			$fastedit_begin.show();
			$fastedit_actions.hide();
			
			fastedit_in_action=false;
			return false;
		});
		
		
		return false;
	});
	
	
}
});

