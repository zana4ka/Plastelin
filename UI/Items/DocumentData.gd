extends ItemData
class_name DocumentData

@export_multiline var DocumentText: String = "Some\nscary text."
@export var IsEditable: bool = false

func GetDocumentText() -> String:
	return TranslationServer.translate(DocumentText)
