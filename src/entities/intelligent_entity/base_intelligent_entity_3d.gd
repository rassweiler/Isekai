extends BaseAnimalEntity3D
class_name BaseIntelligentEntity3D

@export var map_icon_data : Resource = null
#@export_node_path(Node3D) var head_mount_location
#@export_node_path(Node3D) var chest_mount_location
#@export_node_path(Node3D) var hand_r_mount_location
#@export_node_path(Node3D) var hand_l_mount_location
#@export_node_path(Node3D) var back_mount_location
#@export_node_path(Node3D) var waist_mount_location
#@export_node_path(Node3D) var legs_mount_location
#@export_node_path(Node3D) var foot_r_mount_location
#@export_node_path(Node3D) var foot_l_mount_location

var head_mount_item : BaseEquipmentObject3D = null
var chest_mount_item : BaseEquipmentObject3D = null
var hand_r_mount_item : BaseEquipmentObject3D = null
var hand_l_mount_item : BaseEquipmentObject3D = null
var back_mount_item : BaseEquipmentObject3D = null
var waist_mount_litem : BaseEquipmentObject3D = null
var legs_mount_item : BaseEquipmentObject3D = null
var foot_r_mount_item : BaseEquipmentObject3D = null
var foot_l_mount_item : BaseEquipmentObject3D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	
func get_map_icon_data() -> MapIconData:
	return map_icon_data
