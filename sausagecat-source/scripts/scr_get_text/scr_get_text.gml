enum GAME_LANG {
	EN,
	PT
};

global.lang = GAME_LANG.EN;

enum GAME_TEXT {
	REALLY,
	NEVERMIND,
	BACK,
	START,
	SETTINGS,
	CREDITS,
	QUIT,
	MAINMENU
}

global.game_text_all = [
	["Really!", "Nevermind", "Back", "Start game", "Settings", "Credits", "Quit", "Main menu"],
	["Com certeza!", "Deixa pra la...", "Voltar", "Jogar", "Ajustes", "Creditos", "Sair", "Menu principal"]
];

function scr_get_text(_text_id) {
	return global.game_text_all[global.lang][_text_id];
}