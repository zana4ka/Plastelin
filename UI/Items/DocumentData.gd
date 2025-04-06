extends ItemData
class_name DocumentData

@export_multiline var DocumentText: String = "Some\nscary text."

func GetNamePostfix() -> String:
	return ".txt"
