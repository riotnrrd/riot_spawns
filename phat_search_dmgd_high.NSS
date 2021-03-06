// 1sc_search_dmgd_High
/*
	Description:
	When a searchable container is damaged
	the items inside inside may also be damaged.
	A damaged item is removed from hidden loot 
	and replaced by a broken item
	
	Incase the chest hadden't been opened yet this
	script also generates loot, hence there are a
	Unique, High, Norm and Low versions.
*/
// By System_Crush
// 25-7-07
#include "phat_searchable"
#include "phat_searchable_treasure"

void main()
	{
	// This is the High version of the damaged script, it generates
	// 37.5% Chance for items of High quality
	// 25% chance of items of Unique quality
	// 25% chance of items of Normal quality
	// 12.5% chance of items of Low quality
	FillContainer(TREASURE_TYPE_HIGH,TREASURE_TYPE_UNIQUE,TREASURE_TYPE_MED,TREASURE_TYPE_LOW);
	// get the amount of damage that has been dealt to the container
	// and from that calculate how much items in the chest where damaged.
	int iDamage = GetTotalDamageDealt();
	// compare the total search DC against the required DC for
	// all the findable items on the container
	int iCurrentSearchFor = 1;
	int iFindableItems = GetLocalInt(OBJECT_SELF, "findable_items");
	object oBrokenItem;
	int iStackSize;
	while(iCurrentSearchFor < iFindableItems)
		{
		int iCurrentItemDC = GetLocalInt(OBJECT_SELF, ("item_dc" + IntToString(iCurrentSearchFor)));
		// if we deal enough damage to damage the item then break the item
		if(iCurrentItemDC <= iDamage )
			{
			oBrokenItem = GetLocalObject(OBJECT_SELF, ("findable_item" + IntToString(iCurrentSearchFor)));
			// we can't break gold
			if(GetBaseItemType(oBrokenItem) != BASE_ITEM_GOLD)
				{
				DestroyObject(oBrokenItem);
				SpeakString("Something breaks inside the container");
				CreateItemOnObject("n2_it_brokenitem",OBJECT_SELF);
				SetLocalInt(OBJECT_SELF, ("item_dc" + IntToString(iCurrentSearchFor)), 999);
				}
			}
		iCurrentSearchFor = iCurrentSearchFor + 1;
		}
	}