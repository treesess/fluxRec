After you open your fxR sheet, you can find the Apps Script under Extensions like this: 

![image](https://github.com/treesess/fluxRec/assets/20311124/0eea48ab-28c2-4ff6-bebb-192538983530)

**Figure** Here to find Apps Script

Two simple functions are provided here to facilitate your mu. Copy and paste them into your sheet-bound project and run them at the end of every month, after making a copy of your current spreadsheet (check out the SOP for mu). 

Note that:
1) *SpreadsheetApp.openById* is recommended so that you won't delete data in a wrong spreadsheet;
2) You need to update the *newName* and *ss.getSheetByName* and *rng.setFormula* manually. Sorry that no more automation is provided here. 

### Clean up everything in your sheet

	function cleanup() {
	  var ss = SpreadsheetApp.openById("------------your sheet id------------------");
	  var newName = "2312";
	  var sh2 = ss.getSheetByName(newName);
	  var rngMajor = sh2.getRange('D2:AS2233'); // including remarks
	  rngMajor.clearContent();
	  for (var i = 0; i < 2232/3; i++) {
	    var rng1 = sh2.getRange("B"+ (i*3+3));
	    rng1.clearContent();
	    var rng2 = sh2.getRange("B"+ (i*3+4));
	    rng2.clearContent();
	  }
	}

### Set column AU for easy filtering of day

	function setDateRef() {
	  var ss = SpreadsheetApp.openById("------------your sheet id------------------");
	  var sh = ss.getSheetByName("2312")
	  var rng = sh.getRange('AU2:AU2233');
	  rng.setFormula('=CEILING.MATH(((row()-1)/3)/24)+45199+31+30');
	}
