/*
CONTAINS:
BEDSHEETS
LINEN BINS
*/

/obj/item/weapon/bedsheet
	name = "bedsheet"
	desc = "A surprisingly soft linen bedsheet."
	icon = 'icons/obj/items.dmi'
	icon_state = "sheet"
	slot_flags = SLOT_BACK
	plane = MOB_PLANE
	layer = BELOW_MOB_LAYER
	throwforce = 1
	throw_speed = 1
	throw_range = 2
	w_class = ITEMSIZE_SMALL

/obj/item/weapon/bedsheet/attack_self(mob/user as mob)
	user.drop_item()
	if(layer == initial(layer))
		layer = ABOVE_MOB_LAYER
	else
		reset_plane_and_layer()
	add_fingerprint(user)
	return

/obj/item/weapon/bedsheet/attackby(obj/item/I, mob/user)
	if(is_sharp(I))
		user.visible_message("<span class='notice'>\The [user] begins cutting up [src] with [I].</span>", "<span class='notice'>You begin cutting up [src] with [I].</span>")
		if(do_after(user, 50))
			to_chat(user, "<span class='notice'>You cut [src] into pieces!</span>")
			for(var/i in 1 to rand(2,5))
				new /obj/item/weapon/reagent_containers/glass/rag(drop_location())
			qdel(src)
		return
	..()

/obj/item/weapon/bedsheet/blue
	icon_state = "sheetblue"

/obj/item/weapon/bedsheet/green
	icon_state = "sheetgreen"

/obj/item/weapon/bedsheet/orange
	icon_state = "sheetorange"

/obj/item/weapon/bedsheet/purple
	icon_state = "sheetpurple"

/obj/item/weapon/bedsheet/rainbow
	icon_state = "sheetrainbow"

/obj/item/weapon/bedsheet/red
	icon_state = "sheetred"

/obj/item/weapon/bedsheet/yellow
	icon_state = "sheetyellow"

/obj/item/weapon/bedsheet/mime
	icon_state = "sheetmime"

/obj/item/weapon/bedsheet/clown
	icon_state = "sheetclown"
	item_state = "sheetrainbow"

/obj/item/weapon/bedsheet/captain
	icon_state = "sheetcaptain"

/obj/item/weapon/bedsheet/rd
	icon_state = "sheetrd"

/obj/item/weapon/bedsheet/medical
	icon_state = "sheetmedical"

/obj/item/weapon/bedsheet/hos
	icon_state = "sheethos"

/obj/item/weapon/bedsheet/hop
	icon_state = "sheethop"

/obj/item/weapon/bedsheet/ce
	icon_state = "sheetce"

/obj/item/weapon/bedsheet/brown
	icon_state = "sheetbrown"

/obj/item/weapon/bedsheet/ian
	icon_state = "sheetian"

/obj/item/weapon/bedsheet/double
	icon_state = "doublesheet"
	item_state = "sheet"

/obj/item/weapon/bedsheet/bluedouble
	icon_state = "doublesheetblue"
	item_state = "sheetblue"

/obj/item/weapon/bedsheet/greendouble
	icon_state = "doublesheetgreen"
	item_state = "sheetgreen"

/obj/item/weapon/bedsheet/orangedouble
	icon_state = "doublesheetorange"
	item_state = "sheetorange"

/obj/item/weapon/bedsheet/purpledouble
	icon_state = "doublesheetpurple"
	item_state = "sheetpurple"

/obj/item/weapon/bedsheet/rainbowdouble //all the way across the sky.
	icon_state = "doublesheetrainbow"
	item_state = "sheetrainbow"

/obj/item/weapon/bedsheet/reddouble
	icon_state = "doublesheetred"
	item_state = "sheetred"

/obj/item/weapon/bedsheet/yellowdouble
	icon_state = "doublesheetyellow"
	item_state = "sheetyellow"

/obj/item/weapon/bedsheet/mimedouble
	icon_state = "doublesheetmime"
	item_state = "sheetmime"

/obj/item/weapon/bedsheet/clowndouble
	icon_state = "doublesheetclown"
	item_state = "sheetrainbow"

/obj/item/weapon/bedsheet/captaindouble
	icon_state = "doublesheetcaptain"
	item_state = "sheetcaptain"

/obj/item/weapon/bedsheet/rddouble
	icon_state = "doublesheetrd"
	item_state = "sheetrd"

/obj/item/weapon/bedsheet/hosdouble
	icon_state = "doublesheethos"
	item_state = "sheethos"

/obj/item/weapon/bedsheet/hopdouble
	icon_state = "doublesheethop"
	item_state = "sheethop"

/obj/item/weapon/bedsheet/cedouble
	icon_state = "doublesheetce"
	item_state = "sheetce"

/obj/item/weapon/bedsheet/browndouble
	icon_state = "doublesheetbrown"
	item_state = "sheetbrown"

/obj/item/weapon/bedsheet/iandouble
	icon_state = "doublesheetian"
	item_state = "sheetian"

/obj/structure/bedsheetbin
	name = "linen bin"
	desc = "A linen bin. It looks rather cosy."
	icon = 'icons/obj/structures.dmi'
	icon_state = "linenbin-full"
	anchored = 1
	var/amount = 20
	var/list/sheets = list()
	var/obj/item/hidden = null


/obj/structure/bedsheetbin/examine(mob/user)
	..(user)

	if(amount < 1)
		to_chat(user, "There are no bed sheets in the bin.")
		return
	if(amount == 1)
		to_chat(user, "There is one bed sheet in the bin.")
		return
	to_chat(user, "There are [amount] bed sheets in the bin.")


/obj/structure/bedsheetbin/update_icon()
	switch(amount)
		if(0)				icon_state = "linenbin-empty"
		if(1 to amount / 2)	icon_state = "linenbin-half"
		else				icon_state = "linenbin-full"


/obj/structure/bedsheetbin/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/weapon/bedsheet))
		user.drop_item()
		I.loc = src
		sheets.Add(I)
		amount++
		to_chat(user, "<span class='notice'>You put [I] in [src].</span>")
	else if(amount && !hidden && I.w_class < ITEMSIZE_LARGE)	//make sure there's sheets to hide it among, make sure nothing else is hidden in there.
		user.drop_item()
		I.loc = src
		hidden = I
		to_chat(user, "<span class='notice'>You hide [I] among the sheets.</span>")

/obj/structure/bedsheetbin/attack_hand(mob/user as mob)
	if(amount >= 1)
		amount--

		var/obj/item/weapon/bedsheet/B
		if(sheets.len > 0)
			B = sheets[sheets.len]
			sheets.Remove(B)

		else
			B = new /obj/item/weapon/bedsheet(loc)

		B.loc = user.loc
		user.put_in_hands(B)
		to_chat(user, "<span class='notice'>You take [B] out of [src].</span>")

		if(hidden)
			hidden.loc = user.loc
			to_chat(user, "<span class='notice'>[hidden] falls out of [B]!</span>")
			hidden = null


	add_fingerprint(user)

/obj/structure/bedsheetbin/attack_tk(mob/user as mob)
	if(amount >= 1)
		amount--

		var/obj/item/weapon/bedsheet/B
		if(sheets.len > 0)
			B = sheets[sheets.len]
			sheets.Remove(B)

		else
			B = new /obj/item/weapon/bedsheet(loc)

		B.loc = loc
		to_chat(user, "<span class='notice'>You telekinetically remove [B] from [src].</span>")
		update_icon()

		if(hidden)
			hidden.loc = loc
			hidden = null


	add_fingerprint(user)
