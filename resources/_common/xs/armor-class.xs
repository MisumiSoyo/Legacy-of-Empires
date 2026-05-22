void SetArcherArmor(int playerId = -1)
{
    AddAttackForm(playerId, cCavalryClass, cDamageClassArchers);
}


void SetRoyalHeirArmor(int playerId = -1)
{
    AddArmorForm(playerId, cArcherClass, cDamageClassRoyalHeirs, -3);
    AddArmorForm(playerId, cHandCannoneerClass, cDamageClassRoyalHeirs, -3);
}


void SetMonasteryArmor(int playerId = -1)
{
    AddArmorForm(playerId, MonasteryID, cDamageClassMonastery);
    AddArmorForm(playerId, Monastery2ID, cDamageClassMonastery);
    AddArmorForm(playerId, Monastery3ID, cDamageClassMonastery);
    AddArmorForm(playerId, Monastery4ID, cDamageClassMonastery);
}


void SetVillagerArmor(int playerId = -1)
{
    AddArmorForm(playerId, cVillagerClass, cDamageClassVillager);
}


void SetSiegeWeaponAttackArmor(int playerId = -1)
{
    AddAttackForm(playerId, cSiegeWeaponClass, cDamageClassSiegeWeaponAttack, -10);
    AddAttackForm(playerId, cUnpackedSiegeUnitClass, cDamageClassSiegeWeaponAttack, -10);
    AddAttackForm(playerId, cScorpionClass, cDamageClassSiegeWeaponAttack, -10);
}


void SetGunpowderAttackArmor(int playerId = -1)
{
    AddAttackForm(playerId, cHandCannoneerClass, cDamageClassGunpowderAttack);
    AddAttackForm(playerId, ConquistadorID, cDamageClassGunpowderAttack);
    AddAttackForm(playerId, EliteConquistadorID, cDamageClassGunpowderAttack);
    AddAttackForm(playerId, BombardCannonID, cDamageClassGunpowderAttack);
    AddAttackForm(playerId, HoufniceID, cDamageClassGunpowderAttack);
    AddAttackForm(playerId, HussiteWagonID, cDamageClassGunpowderAttack);
    AddAttackForm(playerId, EliteHussiteWagonID, cDamageClassGunpowderAttack);
    AddAttackForm(playerId, PetardID, cDamageClassGunpowderAttack);
}


void SetLightCavalryArmor(int playerId = -1)
{
    AddArmorForm(playerId, ScoutCavalryID, cDamageClassLightCavalry);
    AddArmorForm(playerId, LightCavalryID, cDamageClassLightCavalry);
    AddArmorForm(playerId, HussarID, cDamageClassLightCavalry);
    AddArmorForm(playerId, MagyarHuszarID, cDamageClassLightCavalry);
    AddArmorForm(playerId, EliteMagyarHuszarID, cDamageClassLightCavalry);
}


void SetTradeUnitArmor(int playerId = -1)
{
    AddArmorForm(playerId, cTradeBoatClass, cDamageClassTradeUnit);
    AddArmorForm(playerId, cTradeCartClass, cDamageClassTradeUnit);
}


void SetScoutArmor(int playerId = -1)
{
    AddArmorForm(playerId, ScoutCavalryID, cDamageClassScout);
    AddArmorForm(playerId, LightCavalryID, cDamageClassScout);
    AddArmorForm(playerId, HussarID, cDamageClassScout);
    AddArmorForm(playerId, WingedHussarID, cDamageClassScout);
    AddArmorForm(playerId, MansabdarID, cDamageClassScout);
    AddArmorForm(playerId, VeteranMansabdarID, cDamageClassScout);
    AddArmorForm(playerId, EliteMansabdarID, cDamageClassScout);
    AddArmorForm(playerId, AuxiliaryCavalryID, cDamageClassScout);
    AddArmorForm(playerId, VeteranAuxiliaryCavalryID, cDamageClassScout);
    AddArmorForm(playerId, EliteAuxiliaryCavalryID, cDamageClassScout);
    AddArmorForm(playerId, AuxiliaryCavalry2ID, cDamageClassScout);
    AddArmorForm(playerId, VeteranAuxiliaryCavalry2ID, cDamageClassScout);
    AddArmorForm(playerId, EliteAuxiliaryCavalry2ID, cDamageClassScout);
    AddArmorForm(playerId, EagleScoutID, cDamageClassScout);
    AddArmorForm(playerId, EagleWarriorID, cDamageClassScout);
    AddArmorForm(playerId, EliteEagleWarriorID, cDamageClassScout);
    AddArmorForm(playerId, ChampiScoutID, cDamageClassScout);
    AddArmorForm(playerId, ChampiRunnerID, cDamageClassScout);
    AddArmorForm(playerId, ChampiWarriorID, cDamageClassScout);
    AddArmorForm(playerId, EliteChampiWarriorID, cDamageClassScout);
}


void SetNewArmorForms(int playerId = -1)
{
    SetArcherArmor(playerId);
    SetRoyalHeirArmor(playerId);
    SetMonasteryArmor(playerId);
    SetVillagerArmor(playerId);
    SetGunpowderAttackArmor(playerId);
    SetSiegeWeaponAttackArmor(playerId);
    SetLightCavalryArmor(playerId);
    SetTradeUnitArmor(playerId);
    SetScoutArmor(playerId);
}