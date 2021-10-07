extends KinematicBody2D

#variables
var velocity := Vector2.ZERO
var on_floor := false
var jumps_left := 1
var is_jumping : bool
var is_attacking : bool

onready var Player := get_node("AnimatedSprite")

#constants
const FLOOR = Vector2.UP
const GRAVITY := 40
const SPEED := Vector2(50, 600)


func _ready() -> void:
	pass 

func _physics_process(delta: float) -> void:
	
	#variables
	var right := Input.is_action_pressed("right")
	var left  := Input.is_action_pressed("left")

	
	#attack
	attack()

	if Input.is_action_just_released("attack") or Input.is_action_pressed("attack"):
		velocity.x = 0
		is_attacking = true
		animation_player("Attack")
		yield(Player, "animation_finished")
		is_attacking = false
	elif right and Input.is_action_just_released("attack") or Input.is_action_pressed("attack"):
		velocity.x = 0
		
		
	#jump
	jump()

	if Input.is_action_just_released("jump") or Input.is_action_pressed("jump"):
		is_jumping = true
		animation_player("FirstJump")
	
	
	#movement
	if right and is_attacking == false:
		velocity.x = SPEED.x
		Player.flip_h = false
		if is_jumping == false:
			animation_player("Run")
		
		
	if left and is_attacking == false:
		velocity.x = -SPEED.x
		Player.flip_h = true
		if is_jumping == false:
			animation_player("Run")
		
	
	#idle
	if velocity.x == 0 and is_on_floor() and is_attacking == false:
		animation_player("Idle")
	
	#inertia
	if velocity.x != 0 and !left and !right and is_on_floor() and is_attacking == false:
		animation_player("Inertia")
		if(velocity.x > 0):
			velocity.x -= 5
		elif(velocity.x < 0):
			velocity.x += 5
	
	#checks whether the main character is on floor or not
	if is_on_floor():
		on_floor = true
		is_jumping = false
		jumps_left = 1 
	else:
		on_floor = false
	
	#GRAVITY
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity,FLOOR)
#	print(is_jumping)


#CUSTOM FUNCTIONS
func jump():
	#variables
	var jumping  := Input.is_action_just_pressed("jump")
	
	if jumping and jumps_left > 0:
		if on_floor == true:
			velocity.y = -SPEED.y
			jumps_left -= 1
			

		elif on_floor == false and jumps_left > 0:
			velocity.y = -(SPEED.y)
			jumps_left -= 1

func attack():
	velocity.x = 0
	var attacking := Input.is_action_just_pressed("attack")
	if attacking:
		$"AttackArea/AttackCollision".disabled = false
		$"AttackArea/AttackCollision".visible = true
		print("attack")
	else:
		$"AttackArea/AttackCollision".disabled = true
		$"AttackArea/AttackCollision".visible = false


func animation_player(animation):
	Player.play(animation)
	
