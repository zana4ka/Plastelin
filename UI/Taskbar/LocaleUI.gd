extends Button
class_name LocaleUI

func _ready() -> void:
	toggled.connect(OnToggled)

func OnToggled(InToggledOn: bool):
	
	if InToggledOn:
		text = "РУС"
		TranslationServer.set_locale("ru")
	else:
		text = "ENG"
		TranslationServer.set_locale("en")
