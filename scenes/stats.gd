extends CanvasLayer

onready var traits_node := $Panel/Display/Traits

var stat_mapping: Dictionary = {
	"affection": "Panel/Display/Stats/Affection",
	"respect": "Panel/Display/Stats/Respect",
	"sincerity": "Panel/Display/Stats/Sincerity",
	"synergy": "Panel/Display/Stats/Synergy",
	"similarity": "Panel/Display/Stats/Similarity"
}


func _ready():
	Stats.connect("update_stats", self, "_on_stats_updated")
	Stats.connect("update_traits", self, "_on_traits_updated")

func _on_stats_updated():
	var label: Node
	var value: int
	var text: String
	for stat in Stats.player_stats:
		label = get_node(stat_mapping[stat])
		value = Stats.player_stats[stat]
		text = stat.left(3).capitalize() + ": " + String(value)
		label.text = text

func _on_traits_updated():
	for child in traits_node.get_children():
		child.queue_free()
	for trait in Stats.player_traits:
		if trait != null:
			var label = Label.new()
			label.text = trait
			traits_node.add_child(label)
