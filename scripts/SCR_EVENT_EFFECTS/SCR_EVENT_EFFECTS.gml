
// -------------------------------------------------------------------------------//
enum OPERATOR {
	EQUALS,
	NOT_EQUALS,
	GREATER_THAN,
	LESSER_THAN,
	MULTIPLY,
	PLUS,
	MINUS,
	EXECUTE
}

// @desc Get the enum operator matching the string input
// @param _str a string
function constraint_operator_parse(_str) {
	switch(_str) {
		case "==": return OPERATOR.EQUALS;
		case "!=": return OPERATOR.NOT_EQUALS; 
		case ">": return OPERATOR.GREATER_THAN; 
		case "<": return OPERATOR.LESSER_THAN; 
		case "*": return OPERATOR.MULTIPLY; 
		case "+": return OPERATOR.PLUS; 
		case "-": return OPERATOR.MINUS; 
		case ":": return OPERATOR.EXECUTE;  // used to execute function todo rethink this
		default: throw_and_log("Operator " + _str + " not recognized.");
	}
}

enum ATTRIBUTE {
	LVL,
	INTERACTION_COUNT,
	HP,
	ATK,
	FUNCTION
}

// @desc Get the enum attribute matching the string input
// @param _str a string
function constraint_attribute_parse(_str) {
	switch(string_lower(_str)) {
		case "lvl": return ATTRIBUTE.LVL;
		case "interaction_count": return ATTRIBUTE.INTERACTION_COUNT; 
		case "hp": return ATTRIBUTE.HP; 
		case "atk": return ATTRIBUTE.ATK; 
		case "function": return ATTRIBUTE.FUNCTION; 
		default: throw_and_log("Attribute " + _str + " not recognized.");
	}
}

// @desc Map the _str value to the approriate type according to the attribute
// @param _str the value of the constraint
function constraint_value_parse(_str, _attr) {
	function parse_int(_val, _attr) {
		return real(_val);
	}
	function parse_str(_val, _attr) {
		return _val;
	}
	switch(_attr) {
		case ATTRIBUTE.LVL: return parse_int(_str, _attr);
		case ATTRIBUTE.INTERACTION_COUNT: return parse_int(_str, _attr); 
		case ATTRIBUTE.HP: return parse_int(_str, _attr); 
		case ATTRIBUTE.ATK: return parse_int(_str, _attr); 
		case ATTRIBUTE.FUNCTION: return parse_str(_str, _attr); 
		default: throw_and_log("Attribute " + _attr + " not recognized.");
	}
}

// -----------------------------------------------------------------------------------//
// Parse constraint string in the following format "attribute==value"
// @return A struct { constraint_attribute : xx, constraint_operator : xx, constraint_value : xx }
function parse_constraint_str(_constraint_str) {
	var _operators = ["!=", "==", "<", ">", "*", "+", "-", ":"];
	for (var i=0; i<array_length(_operators); i++) {
		var _parse_result = string_split(_constraint_str, _operators[i]);
		if array_length(_parse_result) == 2 {
			var _constraint_attribute = constraint_attribute_parse(_parse_result[0]);
			var _constraint_value = constraint_value_parse(_parse_result[1], _constraint_attribute);
			var _constraint_operator = constraint_operator_parse(_operators[i]);
			var _constraint = {
				constraint_attribute : _constraint_attribute,
				constraint_operator : _constraint_operator,
				constraint_value : _constraint_value
			}
			return _constraint;
		} else if array_length(_parse_result) > 2 {
			throw_and_log("Invalid number of parsed elements " +  array_length(_parse_result) + " : " + string(_parse_result));
		}
	}
	debug("SHOULD NOT HAPPEN");
}

// @desc Returns a boolean that indicates is the constraint is met (true) or not (false)
function constraint_apply(_constraint) {
	var _attribute = 0;
	switch (_constraint.attribute) {
		case ATTRIBUTE.INTERACTION_COUNT : {
			debug("interac count is ", OBJ_X_TEXT_BOX.caller, ":", OBJ_X_TEXT_BOX.caller.interaction_count);
			_attribute = OBJ_X_TEXT_BOX.caller.interaction_count; break;} // at this point, caller MUST be set;
		case ATTRIBUTE.LVL :  _attribute = OBJ_FIGHTER_PLAYER.LVL;
	}
	return constraint_operator_apply(_attribute, _constraint.value, _constraint.operator);
	
}

function constraint_operator_apply(_value1, _value2, _op) {
	switch(_op) {
		case(OPERATOR.EQUALS): debug("!equals", _value1, "and", _value2);return _value1 == _value2;
		case(OPERATOR.NOT_EQUALS): debug("!notequals", _value1, "and", _value2);return _value1 != _value2;
		case(OPERATOR.GREATER_THAN): debug("!comparing ", _value1, "and", _value2);return _value1 > _value2;
		case(OPERATOR.LESSER_THAN): debug("!lt", _value1, "and", _value2);return _value1 < _value2;
		default: TODO();
	}
}

function effect_operator_apply(_target, _var, _value, _op, _min, _max) {
	var _var_value = variable_instance_get(_target, _var);
	switch(_op) {
		case(OPERATOR.PLUS): variable_instance_set(_target, _var, min(_max, _var_value + _value));break;
		case(OPERATOR.MINUS): variable_instance_set(_target, _var, max(_min, _var_value - _value));break;
		case(OPERATOR.MULTIPLY): variable_instance_set(_target, _var, min(_max, _var_value *_value));break;
		case(OPERATOR.EXECUTE): debug("!exec", _target.label, "and attr ", _var);break;
		default: TODO();
	}
}
	



// @desc Apply effect of an item
function item_effects_apply(_item, _target) {
	var _attribute = 0;
	var _min = -1000;
	var _max = 1000;
	switch (_item.effect.attribute) {
		case ATTRIBUTE.HP : _attribute = "HP"; _min = 0; _max = _target.MAX_HP; break;
		case ATTRIBUTE.ATK : _attribute = "ATK"; _min = 0; break;
		case ATTRIBUTE.FUNCTION: break;
	}
	effect_operator_apply(_target, _attribute, _item.effect.value, _item.effect.operator, _min, _max);
	
}