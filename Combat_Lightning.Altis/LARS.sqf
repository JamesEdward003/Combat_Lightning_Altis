// LARS.sqf //

playSound3D ["A3\dubbing_f_beta\firing_drills\Timing\firing_drills_timing_ROF_4.ogg", player];for "_i" from 1 to 3 do 
{ 
 playSound3D ["A3\dubbing_f_beta\firing_drills\Timing\firing_drills_timing_ROF_4.ogg", player]; 
 sleep 0.35; 
};

playSound3D ["A3\dubbing_f_beta\firing_drills\Timing\firing_drills_timing_ROF_4.ogg", player];LARs_fnc_findRadioProtocols = { 
 if !( canSuspend ) exitWith { _this spawn LARs_fnc_findRadioProtocols }; 
 
 disableSerialization; 
 private [ "_color", "_total", "_totalIndex", "_stxt", "_display", "_ctrlGrp" ]; 
 
 _fnc_getColor = { 
  _r = linearConversion[ 0, _total, _totalIndex, 1, 0 ]; 
  _g = linearConversion[ 0, _total, _totalIndex, 0, 1 ]; 
  _color = [ _r, _g, 0, 1 ] call BIS_fnc_colorRGBAtoHTML; 
 }; 
 
 _fnc_createProgress = { 
 
  createDialog "RscDisplayNotFreezeBig"; 
  waitUntil { _display = findDisplay 100002; !isNull _display }; 
 
  { 
   _ctrl = _display displayCtrl _x; 
   _ctrl ctrlSetPosition [ 0, 0, 0, 0 ]; 
   _ctrl ctrlCommit 0; 
  }forEach [ 101, 1080, 1081, 1082, 1083 ]; 
 
  _stxt = _display ctrlCreate [ "RscStructuredText", 1000 ]; 
  _stxt ctrlSetPosition [ 0, -0.15, 1, 0.1 ]; 
  _stxt ctrlCommit 0; 
 }; 
 
 _fnc_working = { 
  params[ "_count", "_msg" ]; 
  _msg params[ "_prefix", "_suffix" ]; 
 
  _msg = format[ "<t color='%1'>%2</t>", _color, _prefix ]; 
 
  for "_i" from 0 to ( _count % 30 ) do { 
   _msg = format[ "%1.", _msg ]; 
  }; 
 
  _msg = format[ "%1<br/>%2/%3 %4<br/>", _msg, _totalIndex, _total, _suffix ]; 
  _stxt ctrlSetStructuredText parseText _msg; 
 
 }; 
 
 _fnc_getproperties = { 
  params[ "_cfg", "_directory", "_words" ]; 
   
  _properties = configProperties[ _cfg, "true", true ]; 
  { 
   call _fnc_getColor; 
   [ _forEachIndex, [ format[ "Passing %1 - %2", _rootClass, configName _cfg ], "root classes" ] ] call _fnc_working; 
   _name = configName _x; 
   { 
    _path = _x; 
    if !( toLower( _path select [0,3] ) isEqualTo "\a3" ) then { 
     _path = format[ "%1%2", _directory, _path ]; 
    }; 
    if !( loadFile _path isEqualTo "" ) then { 
     _nul = _words pushBack [ format[ "<t color='#FFFF0000'>%1<t/>  <t color='#FF0000FF'>variation %2<t/>", _name, _forEachIndex ], _path ]; 
    }; 
   }forEach getArray( _x ); 
  }forEach _properties; 
 }; 
  
 call _fnc_createProgress; 
  
 if ( isNil "LARs_radioProtocols" ) then { 
   
  LARs_radioProtocols = []; 
  _cfgVoice = ( "true" configClasses( configFile >> "CfgVoice" ) ); 
  { 
   _directory = getArray( _x >> "directories" ) select 0; 
   if !( _directory isEqualTo "" ) then { 
    _displayName = getText( _x >> "displayName" ); 
    _protocol = getText( _x >> "protocol" ); 
    _cfg = configFile >> _protocol >> "Words"; 
     
    _classes = "true" configClasses( _cfg ); 
    _words = []; 
    _nul = _words pushBack [ "Default", [] ]; 
    { 
     _nul = _words pushBack [ configName _x, [] ]; 
    }forEach _classes; 
    _nul = LARs_radioProtocols pushBack [ _displayName, _directory, _cfg, _words ]; 
   }; 
  }forEach _cfgVoice; 
 
  _protocols = LARs_radioProtocols; 
  _total = count LARs_radioProtocols; 
  { 
   _totalIndex = _forEachIndex; 
   call _fnc_getColor; 
   _x params[ "_displayName", "_directory", "_cfg", "_words" ]; 
   _rootClass = _displayName; 
   [ _cfg, _directory, _words select 0 select 1 ] call _fnc_getproperties; 
   { 
    [ _x, _directory, _words select ( _forEachIndex + 1 ) select 1 ] call _fnc_getproperties; 
   }forEach ( "true" configClasses( _cfg )); 
  }forEach _protocols; 
 }; 
 
 LARs_fnc_fillUI = { 
  params[ "_index", "_sec" ]; 
   
  LARs_soundMasterCtrls params[ "_display", "_nameGrp", "_wordGrp", "_stxt" ]; 
  _nameLength = ( ctrlPosition _nameGrp ) select 2;   
 
  _stxt ctrlSetStructuredText parseText "Please wait filling UI.."; 
 
  if !( isNil "LARs_soundCtrls" ) then { 
   { 
    { 
     if ( !isNil "_x" || { !isNull _x } ) then { 
      ctrlDelete _x; 
     }; 
    }forEach _x; 
   }forEach LARs_soundCtrls; 
   { 
    { 
     if ( !isNil "_x" || { !isNull _x } ) then { 
      ctrlDelete _x; 
     }; 
    }forEach _x; 
   }forEach LARs_sectionBtns; 
  }; 
  LARs_soundCtrls = []; 
  LARs_sectionBtns = []; 
   
  for "_btnLanguage" from 0 to count LARs_radioProtocols do { 
   _ctrl = _display displayCtrl 1001 controlsGroupCtrl ( 1010 + _btnLanguage ); 
   if ( _btnLanguage isEqualTo _index ) then { 
    _ctrl ctrlSetTextColor [ 1, 0, 0, 1 ]; 
   }else{ 
    _ctrl ctrlSetTextColor [ 1, 1, 1, 1 ]; 
   }; 
  }; 
   
  _sections = ( LARs_radioProtocols select _index select 3 ); 
  _btnPerRow = ( count _sections ) / 2; 
  _btnLength = 1/_btnPerRow; 
  _btnHeight = 0.03; 
  _btnSpacing = 0.005; 
   
  _picHeight = 0.1; 
  { 
   _sectionIndex = _forEachIndex; 
   _x params[ "_sectionName", "_words" ]; 
    
   _btn = _display ctrlCreate [ "RscButton", 3000 + _forEachIndex ]; 
   _btn ctrlSetPosition [ _btnLength * ( _forEachIndex % _btnPerRow ) , ( -_btnHeight + -_btnSpacing ) * ( 2 - floor( _forEachIndex/_btnPerRow )), _btnLength, _btnHeight ]; 
   _btn ctrlSetText _sectionName; 
   _btn buttonSetAction format[ "[ %1, %2 ] call LARs_fnc_fillUI", _index, _forEachIndex ]; 
   if ( _sectionIndex isEqualTo _sec ) then { 
    _btn ctrlSetTextColor [ 1, 0, 0, 1 ]; 
   }else{ 
    _btn ctrlSetTextColor [ 1, 1, 1, 1 ]; 
   }; 
   _btn ctrlCommit 0; 
    
    
   if ( _sectionIndex isEqualTo _sec ) then { 
    { 
     _x params[ "_name", "_file" ]; 
      
     if ( _file select [ 0, 1 ] isEqualTo "\" ) then { 
      _file = _file select [ 1, count _file ]; 
     }; 
      
     _picGrp = _display ctrlCreate [ "RscControlsGroup", 5000 + _forEachIndex, _wordGrp ]; 
     _picGrp ctrlSetPosition [ 0, _picHeight * _forEachIndex, 1-_nameLength, _picHeight ]; 
     _picGrp ctrlCommit 0; 
 
     _pic = _display ctrlCreate [ "RscActivePictureKeepAspect", 7000 + _forEachIndex, _picGrp ]; 
     _pic ctrlSetPosition [ 0, 0, _picHeight, _picHeight ]; 
     _pic ctrlSetText "\a3\modules_f_curator\data\portraitsound_ca.paa"; 
     _pic buttonSetAction format[ "playSound3D[ %1, player ]; hint 'copied to clipboard'; copyToClipboard str %1", str _file ]; 
     _pic ctrlCommit 0; 
 
     _sTxtDescription = _display ctrlCreate [ "RscStructuredText", 9000 + _forEachIndex, _picGrp ]; 
     _sTxtDescription ctrlSetPosition [ _picHeight, 0, ( 1-_nameLength )-_picHeight, _picHeight ]; 
     _sTxtDescription ctrlSetStructuredText  parseText format[ "%1<br/><t color='#FFFFFFFF'>%2<t/>", _name, _file ]; 
     _sTxtDescription ctrlCommit 0; 
      
     _nul = LARs_soundCtrls pushBack [ _sTxtDescription, _pic, _picGrp ]; 
    }forEach _words; 
   }; 
 
  }forEach _sections; 
 
  _stxt ctrlSetStructuredText parseText "Click speaker icon to preview sound and copy it to the clipboard"; 
 
 }; 
  
 _nameLength = 0.3; 
 _nameHeight = 0.06; 
  
 _nameGrp = _display ctrlCreate [ "RscControlsGroup", 1001 ]; 
 _nameGrp ctrlSetPosition [ 0, 0, _nameLength, 1 ]; 
 _nameGrp ctrlCommit 0; 
  
 _wordGrp = _display ctrlCreate [ "RscControlsGroup", 1002 ]; 
 _wordGrp ctrlSetPosition [ _nameLength, 0, 1-_nameLength, 1 ]; 
 _wordGrp ctrlCommit 0; 
  
 { 
  _x params[ "_displayName", "_directory", "_cfg", "_words" ]; 
  _btn = _display ctrlCreate [ "RscButton", 1010 + _forEachIndex, _nameGrp ]; 
  _btn ctrlSetPosition [ 0, _nameHeight * _forEachIndex, _nameLength, _nameHeight ]; 
  _btn ctrlSetText _displayName; 
  _btn buttonSetAction format[ "[ %1, 0 ] call LARs_fnc_fillUI", _forEachIndex ]; 
  _btn ctrlCommit 0; 
 }forEach LARs_radioProtocols; 
  
 LARs_soundMasterCtrls = [ _display, _nameGrp, _wordGrp, _stxt ]; 
  
 [ 0, 0 ] call LARs_fnc_fillUI; 
}; 
 
[] call LARs_fnc_findRadioProtocols;
