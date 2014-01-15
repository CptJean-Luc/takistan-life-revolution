//_this [player,itemtype]
if (not(isNil "itemquant_functions")) exitWith {};

itemquan_varset = {
  private["_player","_itemtype", "_itemquant"]
    _player         = _this select 0;
    if (not([_player] call player_human)) exitWith {0};
    _itemtype       = _this select 1;
    _itemquan       = 0
};
  
player_get_factory_item = {
  {
    call itemquan_varset
    _factory_array = _x;
    _factory_name = _factory_array select 7;
    _factory_itemquant = [_player, _itemtype, _factory_name] call INV_GetStorageAmount;
    _itemquant = _itemquant + _factory_itemquant;
  } forEach all_factories;
_itemquan
};

player_get_private_storage_item = {
  call itemquan_varset
  ([_player, _itemtype, "private_storage"] call INV_GetStorageAmount);
};

player_get_inventory_item = {
  call itemquan_varset
  ([_player, _itentype] call INV_GetItemAmount)
};

player_get_total_item = {
  call itemquan_varset
  private["_fac_itemquan", "_priv_itemquan", "_inv_itemquan"];
  _fac_itemquan = [_player] call player_get_factory_item;
  _priv_itemquan = [_player] call player_get_private_storage_item;
  _bank_itemquan = [_player] call player_get_inventory_item;
  
  _total_itemquan = _fac_itemquan + _priv_itemquan + _inv_itemquan;
  _total_itemquan
};

itemquant_functions = true;
