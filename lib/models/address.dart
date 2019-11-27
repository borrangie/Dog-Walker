class Address {
  String _province, _city, _locality, _street;
  int _houseNumber, _departmentNumber, _departmentFloor;

  Address.department(this._province, this._city, this._locality, this._street,
      this._departmentNumber, this._departmentFloor);

  Address.house(this._province, this._city, this._locality, this._street,
      this._houseNumber);

  bool get isHouse => _departmentNumber == null;

  get departmentFloor => _departmentFloor;

  get departmentNumber => _departmentNumber;

  int get houseNumber => _houseNumber;

  get street => _street;

  get locality => _locality;

  get city => _city;

  String get province => _province;


}
