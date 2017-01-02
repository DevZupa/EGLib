private["_messages","_overallRespectChange","_messageContent","_scoreName","_scoreString","_scoreStringPad","_i"];


_messages = _this select 0;
_overallRespectChange = 0;
_messageContent = "<t align='right' size='1.25'>";
private _killer = _this select 1;
{
	_scoreName = _x select 0;
	_scoreString = str (_x select 1);
	_scoreStringPad = 7 - (count _scoreString);
	for "_i" from 1 to _scoreStringPad do
	{
		_scoreString = " " + _scoreString;
	};
	_overallRespectChange = _overallRespectChange + (_x select 1);
	_messageContent = _messageContent + format ["<t font='PuristaSemibold'>%1</t>%2<br/>", toUpper _scoreName, _scoreString];
}
forEach _messages;
_messageContent = _messageContent + "</t>";

if (_overallRespectChange >= 0) then
{
	playSound "FD_CP_Clear_F";
	_messageContent = _messageContent + (format ["<t align='right' color='#b2ec00' font='PuristaBold' size='1.4'>+%1</t>", _overallRespectChange]);
}
else
{
	playSound "FD_CP_Not_Clear_F";
	_messageContent = _messageContent + (format ["<t align='right' color='#ea0000' font='PuristaBold' size='1.4'>%1</t>", _overallRespectChange]);
};

diag_log format ["Zupa: sending to: %1 %2",  owner _killer, name _killer];

[
[
  	parseText _messageContent,
  	[safezoneX, safezoneY + safeZoneH * 0.4, safezoneW * 0.3, safeZoneH * 0.25],
  	nil,
  	6,
  	0.7,
  	0
  ],
  "BIS_fnc_textTiles",
  owner _killer
   ] call BIS_fnc_MP;