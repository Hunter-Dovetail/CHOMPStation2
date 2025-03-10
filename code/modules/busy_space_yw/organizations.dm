//Datums for different companies that can be used by busy_space
/datum/lore/organization
	var/name = ""				// Organization's name
	var/short_name = ""			// Organization's shortname (NanoTrasen for "NanoTrasen Incorporated")
	var/acronym = ""			// Organization's acronym, e.g. 'NT' for NanoTrasen'.
	var/desc = ""				// One or two paragraph description of the organization, but only current stuff.  Currently unused.
	var/history = ""			// Historical discription of the organization's origins  Currently unused.
	var/work = ""				// Short description of their work, eg "an arms manufacturer"
	var/headquarters = ""		// Location of the organization's HQ.  Currently unused.
	var/motto = ""				// A motto/jingle/whatever, if they have one.  Currently unused.

	var/list/ship_prefixes = list()	//Some might have more than one! Like NanoTrasen. Value is the mission they perform, e.g. ("ABC" = "mission desc")
	var/complex_tasks = FALSE	//enables complex task generation
	var/list/task_types = list(	//special purpose addition for certain groups, but generally unused
			"logistics",
			"patrol",
			"training",
			"peacekeeping",
			"escort",
			"search and rescue"
			)
	var/list/flight_types = list(		//operations and flights - we can override this if we want to remove the military-sounding ones or add our own
			"flight",
			"mission",
			"route",
			"assignment"
			)
	var/list/ship_names = list(		//Names of spaceships.  This is a mostly generic list that all the other organizations inherit from if they don't have anything better.
			"Scout",
			"Beacon",
			"Signal",
			"Freedom",
			"Liberty",
			"Enterprise",
			"Glory",
			"Axiom",
			"Eternal",
			"Harmony",
			"Light",
			"Discovery",
			"Endeavour",
			"Explorer",
			"Swift",
			"Dragonfly",
			"Ascendant",
			"Tenacious",
			"Pioneer",
			"Surveyor",
			"Haste",
			"Radiant",
			"Luminous",
			"Calypso",
			"Eclipse",
			"Maverick",
			"Polaris",
			"Orion",
			"Odyssey",
			"Relentless",
			"Valor",
			"Zodiac",
			"Avenger",
			"Defiant",
			"Dauntless",
			"Interceptor",
			"Providence",
			"Thunderchild",
			"Defender",
			"Ranger",
			"River",
			"Jubilee",
			"Gumdrop",
			"Spider",
			"Columbia",
			"Eagle",
			"Intrepid",
			"Odyssey",
			"Aquarius",
			"Kitty Hawk",
			"Antares",
			"Falcon",
			"Casper",
			"Orion",
			"Challenger"
			)
	var/list/destination_names = list()	//Names of static holdings that the organization's ships visit regularly.

	var/lawful = TRUE			//Are we exempt from routine inspections? to avoid incidents where SysDef appears to go rogue -- defaults to TRUE now
	var/hostile = FALSE			//Are we explicitly lawless, hostile, or otherwise bad? allows for a finer alignment system, since my last checks weren't working properly
	var/sysdef = FALSE			//Are we the space cops?
	var/autogenerate_destination_names = TRUE //Pad the destination lists with some extra random ones?

/datum/lore/organization/New()
	..()
	if(autogenerate_destination_names) // Lets pad out the destination names.
		var/i = rand(15, 30) //significantly increased from original values due to the greater length of rounds on YW

		//known planets and exoplanets, plus fictional ones
		var/list/planets = list(
			/* real planets */
			"Earth",
			"Luna",
			"Mars",
			"Titan",
			"Europa",
			/* named exoplanets */
			"Spe",
			"Arion",
			"Arkas",
			"Orbitar",
			"Dimidium",
			"Galileo",
			"Brahe",
			"Lipperhey",
			"Janssen",
			"Harriot",
			"Aegir",
			"Amateru",
			"Dagon",
			"Meztli",
			"Smertrios",
			"Hypatia",
			"Quijote",
			"Dulcinea",
			"Rocinante",
			"Sancho",
			"Thestias",
			"Saffar",
			"Samh",
			"Majriti",
			"Fortitudo",
			"Draugr",
			"Arber",
			"Tassili",
			"Madriu",
			"Naqaya",
			"Bocaprins",
			"Yanyan",
			"Sissi",
			"Tondra",
			"Eburonia",
			"Drukyul",
			"Yvaga",
			"Naron",
			"Guarani",
			"Mastika",
			"Bendida",
			"Nakanbe",
			"Awasis",
			"Caleuche",
			"Wangshu",
			"Melquiades",
			"Pipitea",
			"Ditso",
			"Asye",
			"Veles",
			"Finlay",
			"Onasilos",
			"Makropolus",
			"Surt",
			"Boinayel",
			"Eyeke",
			"Cayahuanca",
			"Hamarik",
			"Abol",
			"Hiisi",
			"Belisama",
			"Mintome",
			"Neri",
			"Toge",
			"Iolaus",
			"Koyopa",
			"Independance",
			"Ixbalanque",
			"Magor",
			"Fold",
			"Santamasa",
			"Noifasui",
			"Kavian",
			"Babylonia",
			"Bran",
			"Alef",
			"Lete",
			"Chura",
			"Wadirum",
			"Buru",
			"Umbaasaa",
			"Vytis",
			"Peitruss",
			"Trimobe",
			"Baiduri",
			"Ggantija",
			"Cuptor",
			"Xolotl",
			"Isli",
			"Hairu",
			"Bagan",
			"Laligurans",
			"Kereru",
			"Equiano",
			"Albmi",
			"Perwana",
			"Pollera",
			"Tumearandu",
			"Sumajmajta",
			"Haik",
			"Leklsullun",
			"Pirx",
			"Viriato",
			"Aumatex",
			"Negoiu",
			"Teberda",
			"Dopere",
			"Vlasina",
			"Viculus",
			"Kralomoc",
			"Iztok",
			"Krotoa",
			"Halla",
			"Riosar",
			"Samagiya",
			"Isagel",
			"Eiger",
			"Ugarit",
			"Sazum",
			"Maeping",
			"Agouto",
			"Ramajay",
			"Khomsa",
			"Gokturk",
			"Barajeel",
			"Cruinlagh",
			"Mulchatria",
			"Ibirapita",
			"Madalitso",
			/* fictional planets */
			"Sif",
			"Kara",
			"Rota",
			"Root",
			"Toledo, New Ohio",
			"Meralar",
			"Adhomai",
			"Binma",
			"Kishar",
			"Anshar",
			"Nisp",
			"Elysium",
			"Sophia, El",
			"New Kyoto",
			"Angessa's Pearl, Exalt's Light",
			"Oasis",
			"Love"
			)

		//existing systems, pruned for duplicates, includes systems that contain suspected or confirmed exoplanets
		var/list/systems = list(
			/* real solar systems */
			"Sol",
			"Alpha Centauri",
			"Sirius",
			"Vega",
			"Tau Ceti",
			"Altair",
			"Epsilon Eridani",
			"Fomalhaut",
			"Mu Arae",
			"Pollux",
			"Wolf 359",
			"Ross 128",
			"Gliese 1061",
			"Luyten's Star",
			"Teegarden's Star",
			"Kapteyn",
			"Wolf 1061",
			"Aldebaran",
			"Proxima Centauri",
			"Kepler-90",
			"HD 10180",
			"HR 8832",
			"TRAPPIST-1",
			"55 Cancri",
			"Gliese 876",
			"Upsilon Andromidae",
			"Mu Arae",
			"WASP-47",
			"82 G. Eridani",
			"Rho Coronae Borealis",
			"Pi Mensae",
			"Beta Pictoris",
			"Gamma Librae",
			"Gliese 667 C",
			"LHS 1140",
			"Phact",
			/* fictional systems from Polaris and other sources*/
			"Zhu Que",
			"Oasis",
			"Vir",
			"Gavel",
			"Ganesha",
			"Sidhe",
			"New Ohio",
			"Parvati",
			"Mahi-Mahi",
			"Nyx",
			"New Seoul",
			"Kess-Gendar",
			"Raphael",
			"El",
			"Eutopia",
			/* skrell */
			"Qerr'valis",
			"Harr'Qak",
			"Qerrna-Lakirr",
			"Kauq'xum",
			/* tajaran */
			"Rarkajar",
			"Arrakthiir",
			"Mesomori",
			/* other */
			"Vazzend",
			"Thoth",
			"Jahan's Post",
			"Silk",
			"New Singapore",
			"Stove",
			"Viola",
			"Love",
			"Isavau's Gamble",
			"Samsara",
			"Vounna",
			"Relan",
			"Whythe",
			"Exalt's Light",
			/* generic territories */
			"deep space",
			"USG Territory",
			"Independent Space",
			"Almach Territory",
			"Skrell Territories",
			"Hegemony Space"
			)
		var/list/owners = list("a government", "a civilian", "a corporate", "a private", "an independent", "a mercenary", "a military")
		var/list/purpose = list("an exploration", "a trade", "a research", "a survey", "a military", "a mercenary", "a corporate", "a civilian", "an independent")

		//unique or special locations
		var/list/unique = list("the Jovian subcluster","Isavau International Spaceport","Terminus Station","Casini's Reach","the Shelf flotilla","the Ue'Orsi flotilla","|Heaven| Orbital Complex, Alpha Centauri","the |Saint Columbia| Complex")

		var/list/orbitals = list("[pick(owners)] shipyard","[pick(owners)] dockyard","[pick(owners)] station","[pick(owners)] vessel","a habitat","[pick(owners)] refinery","[pick(owners)] research facility","an industrial platform","[pick(owners)] installation")
		var/list/surface = list("a colony","a settlement","a trade outpost","[pick(owners)] supply depot","a fuel depot","[pick(owners)] installation","[pick(owners)] research facility")
		var/list/deepspace = list("[pick(owners)] asteroid base","a freeport","[pick(owners)] shipyard","[pick(owners)] dockyard","[pick(owners)] station","[pick(owners)] vessel","[pick(owners)] habitat","a trade outpost","[pick(owners)] supply depot","a fuel depot","[pick(owners)] installation","[pick(owners)] research facility")
		var/list/frontier = list("[pick(purpose)] [pick("ship","vessel","outpost")]","a waystation","an outpost","a settlement","a colony")

		//patterns; orbital ("an x orbiting y"), surface ("an x on y"), deep space ("an x in y"), the frontier ("an x on the frontier")
		//biased towards inhabited space sites
		while(i)
			destination_names.Add("[pick("[pick(orbitals)] orbiting [pick(planets)]","[pick(surface)] on [pick(planets)]","[pick(deepspace)] in [pick(systems)]",20;"[pick(unique)]",30;"[pick(frontier)] on the frontier")]")
			i--
	//extensive rework for a much greater degree of variety compared to the old system, lists now include known exoplanets and star systems currently suspected or confirmed to have exoplanets

//////////////////////////////////////////////////////////////////////////////////

// TSCs
/datum/lore/organization/tsc/nanotrasen
	name = "NanoTrasen Incorporated"
	short_name = "NanoTrasen "
	acronym = "NT"
	desc = "NanoTrasen is one of the foremost research and development companies in SolGov space. \
	Originally focused on consumer products, their swift move into the field of Phoron has lead to \
	them being the foremost experts on the substance and its uses. In the modern day, NanoTrasen prides \
	itself on being an early adopter to as many new technologies as possible, often offering the newest \
	products to their employees. In an effort to combat complaints about being 'guinea pigs', Nanotrasen \
	also offers one of the most comprehensive medical plans in SolGov space, up to and including cloning \
	and therapy.\
	<br><br>\
	NT's most well known products are its phoron based creations, especially those used in Cryotherapy. \
	It also boasts an prosthetic line, which is provided to its employees as needed, and is used as an incentive \
	for newly tested posibrains to remain with the company. \
	<br><br>\
	NT's ships are named for famous scientists."
	history = "" // To be written someday.
	work = "research giant"
	headquarters = "Luna, Sol"
	motto = ""

	ship_prefixes = list("NTV" = "a general operations", "NEV" = "an exploration", "NGV" = "a hauling", "NDV" = "a patrol", "NRV" = "an emergency response", "NDV" = "an asset protection")
	//Scientist naming scheme
	ship_names = list(
			"Bardeen",
			"Einstein",
			"Feynman",
			"Sagan",
			"Tyson",
			"Galilei",
			"Jans",
			"Fhriede",
			"Franklin",
			"Tesla",
			"Curie",
			"Darwin",
			"Newton",
			"Pasteur",
			"Bell",
			"Mendel",
			"Kepler",
			"Edison",
			"Cavendish",
			"Nye",
			"Hawking",
			"Aristotle",
			"Von Braun",
			"Kaku",
			"Oppenheimer",
			"Renwick",
			"Hubble",
			"Alcubierre",
			"Robineau",
			"Glass"
			)
	// Note that the current station being used will be pruned from this list upon being instantiated
	destination_names = list(
			"NT HQ on Luna",
			"NSS Exodus in Nyx",
			"NCS Northern Star in Vir",
			"NLS Southern Cross in Vir",
			"NAS Vir Central Command",
			"NAB Smythside Central Headquarters in Sol",
			"NAS Zeus orbiting Virgo-Prime",
			"NIB Posideon in Alpha Centauri",
			"NTB An-Nur on Virgo-Prime",
			"the ruins of Virgo-3B", //YW EDIT
			"the NanoTrasen phoron refinery in Vilous",
			"a dockyard orbiting Virgo-Prime",
			"an asteroid orbiting Virgo 3",
			"Vir Interstellar Spaceport"
			)

/datum/lore/organization/tsc/nanotrasen/New()
	..()
	spawn(1) // BYOND shenanigans means using_map is not initialized yet.  Wait a tick.
		// Get rid of the current map from the list, so ships flying in don't say they're coming to the current map.
		var/string_to_test = "[using_map.station_name] in [using_map.starsys_name]"
		if(string_to_test in destination_names)
			destination_names.Remove(string_to_test)

/datum/lore/organization/tsc/hephaestus
	name = "Hephaestus Industries"
	short_name = "Hephaestus "
	acronym = "HI"
	desc = "Hephaestus Industries is the largest supplier of arms, ammunition, and small millitary vehicles in USG space. \
	Hephaestus products have a reputation for reliability, and the corporation itself has a noted tendency to stay removed \
	from corporate politics. They enforce their neutrality with the help of a fairly large asset-protection contingent which \
	prevents any contracting polities from using their own materiel against them. SolGov itself is one of Hephaestus' largest \
	bulk contractors owing to the above factors. \
	<br><br> \
	Hephaestus' fleet uses identifiers from various deities and spirits of war from Earth's various belief systems."
	history = ""
	work = "arms manufacturer"
	headquarters = "Luna, Sol"
	motto = ""

	ship_prefixes = list("HCV" = "a general operations", "HTV" = "a freight", "HLV" = "a munitions resupply", "HDV" = "an asset protection", "HDV" = "a preemptive deployment")
	//War God Theme, updated
	ship_names = list(
			"Anhur",
			"Bast",
			"Horus",
			"Maahes",
			"Neith",
			"Pakhet",
			"Sekhmet",
			"Set",
			"Sobek",
			"Maher",
			"Kokou",
			"Ogoun",
			"Oya",
			"Kovas",
			"Agrona",
			"Andraste",
			"Anann",
			"Badb",
			"Belatucadros",
			"Cicolluis",
			"Macha",
			"Neit",
			"Nemain",
			"Rudianos",
			"Chiyou",
			"Guan Yu",
			"Jinzha",
			"Nezha",
			"Zhao Lang",
			"Laran",
			"Menrva",
			"Tyr",
			"Woden",
			"Freya",
			"Odin",
			"Ullr",
			"Ares",
			"Deimos",
			"Enyo",
			"Kratos",
			"Kartikeya",
			"Mangala",
			"Parvati",
			"Shiva",
			"Vishnu",
			"Shaushka",
			"Wurrukatte",
			"Hadur",
			"Futsunushi",
			"Sarutahiko",
			"Takemikazuchi",
			"Neto",
			"Agasaya",
			"Belus",
			"Ishtar",
			"Shala",
			"Huitzilopochtli",
			"Tlaloc",
			"Xipe-Totec",
			"Qamaits",
			"'Oro",
			"Rongo",
			"Ku",
			"Pele",
			"Maru",
			"Tumatauenga",
			"Bellona",
			"Juno",
			"Mars",
			"Minerva",
			"Victoria",
			"Anat",
			"Astarte",
			"Perun",
			"Cao Lo"
			)
	destination_names = list(
			"our headquarters on Luna",
			"a SolGov dockyard on Luna",
			"a Fleet outpost in the Almach Rim",
			"a Fleet outpost on the Moghes border"
			)

/datum/lore/organization/tsc/vey_med
	name = "Vey-Medical" //The Wiki displays them as Vey-Medical.
	short_name = "Vey-Med "
	acronym = "VM"
	desc = "Vey-Med is one of the newer TSCs on the block and is notable for being largely owned and operated by Skrell. \
	Despite the suspicion and prejudice leveled at them for their alien origin, Vey-Med has obtained market dominance in \
	the sale of medical equipment-- from surgical tools to large medical devices to the Odysseus trauma response mecha \
	and everything in between. Their equipment tends to be top-of-the-line, most obviously shown by their incredibly \
	human-like FBP designs. Vey's rise to stardom came from their introduction of resurrective cloning, although in \
	recent years they've been forced to diversify as their patents expired and NanoTrasen-made medications became \
	essential to modern cloning. \
	<br><br> \
	For reasons known only to the board, Vey-Med's ship names seem to follow the same naming pattern as the Dionae use."
	history = ""
	work = "medical equipment supplier"
	headquarters = "Toledo, New Ohio"
	motto = ""

	ship_prefixes = list("VMV" = "a general operations", "VTV" = "a transportation", "VHV" = "a medical resupply", "VSV" = "a research", "VRV" = "an emergency medical support")
	// Diona names
	ship_names = list(
			"Wind That Stirs The Waves",
			"Sustained Note Of Metal",
			"Bright Flash Reflecting Off Glass",
			"Veil Of Mist Concealing The Rock",
			"Thin Threads Intertwined",
			"Clouds Drifting Amid Storm",
			"Loud Note And Breaking",
			"Endless Vistas Expanding Before The Void",
			"Fire Blown Out By Wind",
			"Star That Fades From View",
			"Eyes Which Turn Inwards",
			"Joy Without Which The World Would Come Undone",
			"A Thousand Thousand Planets Dangling From Branches",
			"Light Streaming Through Interminable Branches",
			"Smoke Brought Up From A Terrible Fire",
			"Light of Qerr'Valis",
			"King Xae'uoque",
			"Memory of Kel'xi",
			"Xi'Kroo's Herald"
			)
	destination_names = list(
			"our headquarters on Toledo, New Ohio",
			"a research facility in Samsara",
			"a sapientarian mission in the Almach Rim"
			)

/datum/lore/organization/tsc/zeng_hu
	name = "Zeng-Hu Pharmaceuticals"
	short_name = "Zeng-Hu "
	acronym = "ZH"
	desc = "Zeng-Hu is an old TSC, based in the Sol system. Until the discovery of Phoron, Zeng-Hu maintained a stranglehold \
	on the market for medications, and many household names are patentted by Zeng-Hu-- Bicaridine, Dylovene, Tricordrazine, \
	and Dexalin all came from Zeng-Hu medical laboratories. Zeng-Hu's fortunes have been in decline as Nanotrasen's near monopoly \
	on phoron research cuts into their R&D and Vey-Med's superior medical equipment effectively decimated their own equipment \
	interests. The three-way rivalry between these companies for dominance in the medical field is well-known and a matter of \
	constant economic speculation. \
	<br><br> \
	Not to be outdone by NT in the recognition of famous figures, Zeng-Hu has adopted the names of famous physicians for their fleet."
	history = ""
	work = "pharmaceuticals company"
	headquarters = "Earth, Sol"
	motto = ""

	ship_prefixes = list("ZHV" = "a general operations", "ZTV" = "a transportation", "ZMV" = "a medical resupply", "ZRV" = "a medical research")
	//ship names: a selection of famous physicians who advanced the cause of medicine
	ship_names = list(
			"Averroes",
			"Avicenna",
			"Banting",
			"Billroth",
			"Blackwell",
			"Blalock",
			"Charaka",
			"Chauliac",
			"Cushing",
			"Domagk",
			"Galen",
			"Fauchard",
			"Favaloro",
			"Fleming",
			"Fracastoro",
			"Goodfellow",
			"Gray",
			"Harvey",
			"Heimlich",
			"Hippocrates",
			"Hunter",
			"Isselbacher",
			"Jenner",
			"Joslin",
			"Kocher",
			"Laennec",
			"Lane-Claypon",
			"Lister",
			"Lower",
			"Madhav",
			"Maimonides",
			"Marshall",
			"Mayo",
			"Meyerhof",
			"Minot",
			"Morton",
			"Needleman",
			"Nicolle",
			"Osler",
			"Penfield",
			"Raichle",
			"Ransohoff",
			"Rhazes",
			"Semmelweis",
			"Starzl",
			"Still",
			"Susruta",
			"Urbani",
			"Vesalius",
			"Vidius",
			"Whipple",
			"White",
			"Worcestor",
			"Yegorov",
			"Xichun"
			)
	destination_names = list(
			"our headquarters on Earth"
			)

/datum/lore/organization/tsc/ward_takahashi
	name = "Ward-Takahashi General Manufacturing Conglomerate"
	short_name = "Ward-Takahashi "
	acronym = "WT"
	desc = "Ward-Takahashi focuses on the sale of small consumer electronics, with its computers, communicators, \
	and even mid-class automobiles a fixture of many households. Less famously, Ward-Takahashi also supplies most \
	of the AI cores on which vital control systems are mounted, and it is this branch of their industry that has \
	led to their tertiary interest in the development and sale of high-grade AI systems. Ward-Takahashi's economies \
	of scale frequently steal market share from Nanotrasen's high-price products, leading to a bitter rivalry in the \
	consumer electronics market. \
	<br><br> \
	Ward-Takahashi are a mild anomaly in the TSC fleet-naming game, as they've opted to use stellar phenomena."
	history = ""
	work = "electronics manufacturer"
	headquarters = ""
	motto = ""

	ship_prefixes = list("WTV" = "a general operations", "WTFV" = "a freight", "WTGV" = "a transport", "WTDV" = "an asset protection")
	ship_names = list(
			"Comet",
			"Meteor",
			"Heliosphere",
			"Bolide",
			"Aurora",
			"Nova",
			"Supernova",
			"Nebula",
			"Galaxy",
			"Starburst",
			"Constellation",
			"Pulsar",
			"Quark",
			"Void",
			"Asteroid",
			"Wormhole",
			"Sunspot",
			"Supercluster",
			"Supergiant",
			"Protostar",
			"Magnetar",
			"Moon",
			"Supermoon",
			"Anomaly",
			"Drift",
			"Stream",
			"Rift",
			"Curtain",
			"Planetar",
			"Quasar",
			"Binary"
			)
	destination_names = list()

/datum/lore/organization/tsc/bishop
	name = "Bishop Cybernetics"
	short_name = "Bishop "
	acronym = "BC"
	desc = "Bishop's focus is on high-class, stylish cybernetics. A favorite among transhumanists (and an easy target for \
	bioconservatives), Bishop manufactures not only prostheses but also brain augmentation, synthetic organ replacements, \
	and odds and ends like implanted wrist-watches. Their business model tends towards smaller, boutique operations, giving \
	it a reputation for high price and luxury, with Bishop cyberware often rivalling Vey-Med's for cost. Bishop's reputation \
	for catering towards the interests of human augmentation enthusiasts instead of positronics have earned it ire from the \
	Positronic Rights Group and puts it in ideological (but not economic) competition with Morpheus Cyberkinetics. \
	<br><br> \
	Each vessel in Bishop's sleek and stylish fleet is intended to advertise the corporate style, and bears the name of a famous mechanical engineer."
	history = ""
	work = "cybernetics and augmentation manufacturer"
	headquarters = ""
	motto = ""

	ship_prefixes = list("BCV" = "a general operations", "BCTV" = "a transportation", "BCSV" = "a research exchange")
	//famous mechanical engineers
	ship_names = list(
			"Al-Jazari",
			"Al-Muradi",
			"Al-Zarqali",
			"Archimedes",
			"Arkwright",
			"Armstrong",
			"Babbage",
			"Barsanti",
			"Benz",
			"Bessemer",
			"Bramah",
			"Brunel",
			"Cardano",
			"Cartwright",
			"Cayley",
			"Clement",
			"Leonardo da Vinci",
			"Diesel",
			"Drebbel",
			"Fairbairn",
			"Fontana",
			"Fourneyron",
			"Fulton",
			"Fung",
			"Gantt",
			"Garay",
			"Hackworth",
			"Harrison",
			"Hornblower",
			"Jacquard",
			"Jendrassik",
			"Leibniz",
			"Ma Jun",
			"Maudslay",
			"Metzger",
			"Murdoch",
			"Nasmyth",
			"Parsons",
			"Rankine",
			"Reynolds",
			"Roberts",
			"Scheutz",
			"Sikorsky",
			"Somerset",
			"Stephenson",
			"Stirling",
			"Tesla",
			"Vaucanson",
			"Vishweswarayya",
			"Wankel",
			"Watt",
			"Wiberg"
			)
	destination_names = list(
			"a medical facility in Angessa's Pearl"
			)

/datum/lore/organization/tsc/morpheus
	name = "Morpheus Cyberkinetics"
	short_name = "Morpheus "
	acronym = "MC"
	desc = "The only large corporation run by positronic intelligences, Morpheus caters almost exclusively to their sensibilities \
	and needs. A product of the synthetic colony of Shelf, Morpheus eschews traditional advertising to keep their prices low and \
	relied on word of mouth among positronics to reach their current economic dominance. Morpheus in exchange lobbies heavily for \
	positronic rights, sponsors positronics through their Jans-Fhriede test, and tends to other positronic concerns to earn them \
	the good-will of the positronics, and the ire of those who wish to exploit them. \
	<br><br> \
	Morpheus' fleet bears the names of periodic elements. They initially wanted to go with complex compounds, but realized that \
	such designations would be unwieldy and inefficient for regular usage."
	history = ""
	work = "cybernetics manufacturer"
	headquarters = "Shelf flotilla"
	motto = ""

	ship_prefixes = list("MCV" = "a general operations", "MTV" = "a freight", "MDV" = "a market protection", "MSV" = "an outreach")
	//periodic elements; something 'unusual' for the posibrain TSC without being full on 'quirky' culture ship names (much as I love them, they're done to death)
	ship_names = list(
			"Hydrogen",
			"Helium",
			"Lithium",
			"Beryllium",
			"Boron",
			"Carbon",
			"Nitrogen",
			"Oxygen",
			"Fluorine",
			"Neon",
			"Sodium",
			"Magnesium",
			"Aluminium",
			"Silicon",
			"Phosphorus",
			"Sulfur",
			"Chlorine",
			"Argon",
			"Potassium",
			"Calcium",
			"Scandium",
			"Titanium",
			"Vanadium",
			"Chromium",
			"Manganese",
			"Iron",
			"Cobalt",
			"Nickel",
			"Copper",
			"Zinc",
			"Gallium",
			"Germanium",
			"Arsenic",
			"Selenium",
			"Bromine",
			"Krypton",
			"Rubidium",
			"Strontium",
			"Yttrium",
			"Zirconium",
			"Niobium",
			"Molybdenum",
			"Technetium",
			"Ruthenium",
			"Rhodium",
			"Palladium",
			"Silver",
			"Cadmium",
			"Indium",
			"Tin",
			"Antimony",
			"Tellurium",
			"Iodine",
			"Xenon",
			"Caesium",
			"Barium"
			)
	//some hebrew alphabet destinations for a little extra unusualness
	destination_names = list(
			"our headquarters, the Shelf flotilla",
			"one of our factory complexes on Root",
			"research outpost Aleph",
			"logistics depot Dalet",
			"research installation Zayin",
			"research base Tsadi",
			"manufacturing facility Samekh"
		)

/datum/lore/organization/tsc/xion
	name = "Xion Manufacturing Group"
	short_name = "Xion "
	acronym = "XMG"
	desc = "Xion, quietly, controls most of the market for industrial equipment. Their portfolio includes mining exosuits, \
	factory equipment, rugged positronic chassis, and other pieces of equipment vital to the function of the economy. Xion \
	keeps its control of the market by leasing, not selling, their equipment, and through infamous and bloody patent protection \
	lawsuits. Xion are noted to be a favorite contractor for SolGov engineers, owing to their low cost and rugged design. \
	<br><br> \
	Xion's fleet bears the name of mountains and terrain features on Mars."
	history = ""
	work = "industrial equipment manufacturer"
	headquarters = ""
	motto = ""

	ship_prefixes = list("XMV" = "a general operations", "XTV" = "a hauling", "XFV" = "a bulk transport", "XIV" = "a resupply")
	//martian mountains
	ship_names = list(
			"Olympus Mons",
			"Ascraeus Mons",
			"Arsia Mons",
			"Pavonis Mons",
			"Elysium Mons",
			"Hecates Tholus",
			"Albor Tholus",
			"Tharsis Tholus",
			"Biblis Tholus",
			"Alba Mons",
			"Ulysses Tholus",
			"Mount Sharp",
			"Uranius Mons",
			"Anseris Mons",
			"Hadriacus Mons",
			"Euripus Mons",
			"Tyrrhenus Mons",
			"Promethei Mons",
			"Chronius Mons",
			"Apollinaris Mons",
			"Gonnus Mons",
			"Syrtis Major Planum",
			"Amphitrites Patera",
			"Nili Patera",
			"Pityusa Patera",
			"Malea Patera",
			"Peneus Patera",
			"Labeatis Mons",
			"Issidon Paterae",
			"Pindus Mons",
			"Meroe Patera",
			"Orcus Patera",
			"Oceanidum Mons",
			"Horarum Mons",
			"Peraea Mons",
			"Octantis Mons",
			"Galaxius Mons",
			"Hellas Planitia"
			)
	destination_names = list()

/datum/lore/organization/tsc/ftu
	name = "Free Trade Union"
	short_name = "Trade Union "
	acronym = "FTU"
	desc = "The Free Trade Union is different from other tran-stellars in that they are not just a company, but they are a big conglomerate of various traders and merchants from all over the galaxy. They control a sizable fleet of vessels of various sizes which are given autonomy from the central command to engage in trading. They also host a fleet of combat vessels which respond directly to the central command for defending traders when necessary. They are in control of many large scale 'freeport' trade stations across the known galaxy, even in non-human space. Generally, they are multi-purpose stations but they always keep areas filled with duty-free shops, where almost anything you can imagine can be found - so long as it's not outrageously illegal or hideously expensive.<br><br>They are the creators of the Tradeband language, created specially for being a lingua franca where every merchant can understand each other independent of language or nationality.<br><br>The Union doesn't maintain a particularly large fleet of its own, preferring to rely on contracted independent traders that are allowed to use their own designations and identifiers, but the ships it does operate fly under the names of historic merchants."
	history = "The Free Trade Union was created in 2410 by Issac Adler, a merchant, economist, and owner of a small fleet of ships. At this time the \"Free Merchants\" were in decay because of the high taxes and tariffs that were generally applied on the products that they tried to import or export. Another issue was that big trans-stellar corporations were constantly blocking their products to prospective buyers in order to form their monopolies. Issac decided to organize the \"Free Merchants\" into a legitimate organization to lobby and protest against the unfair practices of the major corporations and the governments that were in their pocket. At the same time, they wanted to organize and sell their things at better prices. The organization started relatively small but by 2450 it became one of the biggest conglomerates with a significant amount of the merchants of the galaxy being a part of the FTU. At the same time, the Free Trade Union started to popularize tradeband in the galaxy as the language of business. Around 2500, the majority of independent merchants were part of the FTU with significant influence on the galactic scale. They have started to invest in colonization efforts in order to take early claim of the frontier systems as the best choice for frontier traders."
	work = ""
	headquarters = ""
	motto = ""

	ship_prefixes = list("FTV" = "a general operations", "FTRP" = "a trade protection", "FTRR" = "a piracy suppression", "FTLV" = "a logistical support", "FTTV" = "a mercantile", "FTDV" = "a market establishment")
	//famous merchants and traders, taken from Civ6's Great Merchants, plus the TSC's founder
	ship_names = list(
			"Isaac Adler",
			"Colaeus",
			"Marcus Licinius Crassus",
			"Zhang Qian",
			"Irene of Athens",
			"Marco Polo",
			"Piero de' Bardi",
			"Giovanni de' Medici",
			"Jakob Fugger",
			"Raja Todar Mal",
			"Adam Smith",
			"John Jacob Astor",
			"John Spilsbury",
			"John Rockefeller",
			"Sarah Breedlove",
			"Mary Katherine Goddard",
			"Helena Rubenstein",
			"Levi Strauss",
			"Melitta Bentz",
			"Estee Lauder",
			"Jamsetji Tata",
			"Masaru Ibuka",
			)
	destination_names = list(
			"a Free Trade Union office",
			"FTU HQ"
			)

/datum/lore/organization/tsc/mbt
	name = "Major Bill's Transportation"
	short_name = "Major Bill's "
	acronym = "MBT"
	desc = "The most popular courier service and starliner, Major Bill's is an unassuming corporation whose greatest asset is their low cost and brand recognition. Major Bill's is known, perhaps unfavorably, for its mascot, Major Bill, a cartoonish military figure that spouts quotable slogans. Their motto is \"With Major Bill's, you won't pay major bills!\", an earworm much of the galaxy longs to forget. \
	<br><br> \
	Their ships are named after some of Earth's greatest rivers."
	history = ""
	work = "courier and passenger transit"
	headquarters = "Mars, Sol"
	motto = "With Major Bill's, you won't pay major bills!"

	ship_prefixes = list("TTV" = "a general operations", "TTV" = "a transport", "TTV" = "a luxury transit", "TTV" = "a priority transit", "TTV" = "a secure data courier")
	//ship names: big rivers
	ship_names = list (
			"Nile",
			"Kagera",
			"Nyabarongo",
			"Mwogo",
			"Rukarara",
			"Amazon",
			"Ucayali",
			"Tambo",
			"Ene",
			"Mantaro",
			"Yangtze",
			"Mississippi",
			"Missouri",
			"Jefferson",
			"Beaverhead",
			"Red Rock",
			"Hell Roaring",
			"Yenisei",
			"Angara",
			"Yelenge",
			"Ider",
			"Ob",
			"Irtysh",
			"Rio de la Plata",
			"Parana",
			"Rio Grande",
			"Congo",
			"Chambeshi",
			"Amur",
			"Argun",
			"Kherlen",
			"Lena",
			"Mekong",
			"Mackenzie",
			"Peace",
			"Finlay",
			"Niger",
			"Brahmaputra",
			"Tsangpo",
			"Murray",
			"Darling",
			"Culgoa",
			"Balonne",
			"Condamine",
			"Tocantins",
			"Araguaia",
			"Volga"
			)
	destination_names = list(
			"Major Bill's Transportation HQ on Mars",
			"a Major Bill's warehouse",
			"a Major Bill's distribution center",
			"a Major Bill's supply depot"
			)

/datum/lore/organization/tsc/grayson
	name = "Grayson Manufactories Ltd."
	short_name = "Grayson "
	acronym = "GM"
	desc = "Grayson Manufactories Ltd. is one of the oldest surviving TSCs, having been in 'the biz' almost since mankind began to colonize the rest of the Sol system and thus exploit abundant 'extraterrestrial' resources. Where many choose to go into the high end markets, however, Grayson makes their money by providing foundations for other businesses; they run some of the largest mining and refining operations in all of human-inhabited space. Ore is hauled out of Grayson-owned mines, transported on Grayson-owned ships, and processed in Grayson-owned refineries, then sold by Grayson-licensed vendors to other industries. Several of their relatively newer ventures include heavy industrial equipment, which has earned a reputation for being surprisingly reliable.<br><br>Grayson may maintain a neutral stance towards their fellow TSCs, but can be quite aggressive in the markets that it already holds. A steady stream of rumors suggests they're not shy about engaging in industrial sabotage or calling in strikebreakers, either. \
	<br><br> \
	Fitting their 'down to earth' reputation, Grayson's corporate fleet uses the names of various forms of rock and mineral to identify their vessels."
	history = ""
	work = ""
	headquarters = "Mars, Sol"
	motto = ""

	ship_prefixes = list("GMV" = "a general operations", "GMT" = "a transport", "GMR" = "a resourcing", "GMS" = "a surveying", "GMH" = "a bulk transit")
	//rocks
	ship_names = list(
			"Adakite",
			"Andesite",
			"Basalt",
			"Basanite",
			"Diorite",
			"Dunite",
			"Gabbro",
			"Granite",
			"Harzburgite",
			"Ignimbrite",
			"Kimberlite",
			"Komatiite",
			"Norite",
			"Obsidian",
			"Pegmatite",
			"Picrite",
			"Pumice",
			"Rhyolite",
			"Scoria",
			"Syenite",
			"Tachylyte",
			"Wehrlite",
			"Arkose",
			"Chert",
			"Dolomite",
			"Flint",
			"Laterite",
			"Marl",
			"Oolite",
			"Sandstone",
			"Shale",
			"Anthracite",
			"Gneiss",
			"Granulite",
			"Mylonite",
			"Schist",
			"Skarn",
			"Slate"
			)
	destination_names = list(
			"our headquarters on Mars",
			"one of our manufacturing complexes",
			"one of our mining installations"
			)

/datum/lore/organization/tsc/aether
	name = "Aether Atmospherics & Recycling"
	short_name = "Aether "
	acronym = "AAR"
	desc = "Aether Atmospherics and Recycling is the prime maintainer and provider of atmospherics systems across both the many ships that navigate the vast expanses of space, and the life support on current and future Human colonies. The byproducts from the filtration of atmospheres across the galaxy are then resold for a variety of uses to those willing to buy. With the nature of their services, most work they do is contracted for construction of these systems, or staffing to maintain them for colonies across human space. \
	<br><br> \
	Somewhat unimaginatively, Aether has adopted the names of various types of weather for their fleet."
	history = ""
	work = ""
	headquarters = ""
	motto = "Dum spiro spero"

	ship_prefixes = list("AARV" = "a general operations", "AARE" = "a resource extraction", "AARG" = "a gas transport", "AART" = "a transport")
	//weather systems/patterns
	ship_names = list (
			"Cloud",
			"Nimbus",
			"Fog",
			"Vapor",
			"Haze",
			"Smoke",
			"Thunderhead",
			"Veil",
			"Steam",
			"Mist",
			"Noctilucent",
			"Nacreous",
			"Cirrus",
			"Cirrostratus",
			"Cirrocumulus",
			"Aviaticus",
			"Altostratus",
			"Altocumulus",
			"Stratus",
			"Stratocumulus",
			"Cumulus",
			"Fractus",
			"Asperitas",
			"Nimbostratus",
			"Cumulonimbus",
			"Pileus",
			"Arcus"
			)
	destination_names = list(
			"Aether HQ",
			"a gas mining orbital",
			"a liquid extraction plant"
			)

/datum/lore/organization/tsc/focalpoint
	name = "Focal Point Energistics"
	short_name = "Focal "
	acronym = "FPE"
	desc = "Focal Point Energistics is an electrical engineering solutions firm originally formed as a conglomerate of Earth power companies and affiliates. Focal Point manufactures and distributes vital components in modern power grids, such as TEGs, PSUs and their specialty product, the SMES. The company is often consulted and contracted by larger organisations due to their expertise in their field.\
	<br><br> \
	Keeping in theme with the other big TSCs, Focal's fleet (which is comprised almost entirely of transports and engineering vessels) uses the names of electrical engineers."
	history = ""
	work = ""
	headquarters = ""
	motto = ""

	ship_prefixes = list("FPV" = "a general operations", "FPH" = "a transport", "FPC" = "an energy relay", "FPT" = "a fuel transport")
	//famous electrical engineers
	ship_names = list (
			"Erlang",
			"Blumlein",
			"Taylor",
			"Bell",
			"Reeves",
			"Bennett",
			"Volta",
			"Blondel",
			"Beckman",
			"Hirst",
			"Lamme",
			"Bright",
			"Armstrong",
			"Ayrton",
			"Bardeen",
			"Fuller",
			"Boucherot",
			"Brown",
			"Brush",
			"Burgess",
			"Camras",
			"Crompton",
			"Deprez",
			"Elwell",
			"Entz",
			"Faraday",
			"Halas",
			"Hounsfield",
			"Immink",
			"Laithwaite",
			"McKenzie",
			"Moog",
			"Moore",
			"Pierce",
			"Ronalds",
			"Shallenberger",
			"Siemens",
			"Spencer",
			"Tesla",
			"Yablochkov",
			)
	destination_names = list(
			"Focal Point HQ"
			)

/datum/lore/organization/tsc/starlanes
	name = "StarFlight Inc."
	short_name = "StarFlight "
	acronym = "SFI"
	desc = "Founded in 2437 by Astara Junea, StarFlight Incorporated is now one of the biggest passenger liner businesses in human-occupied space and has even begun breaking into alien markets -  all despite a rocky start, and several high-profile ship disappearances and shipjackings. With space traffic at an all-time high, it's a depressing reality that SFI's incidents are just a tiny drop in the bucket compared to everything else going on. \
	<br><br> \
	SFI's fleet is, somewhat endearingly, named after various species of bird, though the designation " + span_italics("Pigeon") + " was removed from the lineup after a particularly unusual chain of events involving a business liner. For reasons that have continued to remain unclear since the company's foundation, SFI vessels are permitted to use the same high-level identifier pattern as governmental vessels."
	history = ""
	work = "luxury, business, and economy passenger flights"
	headquarters = "Spin Aerostat, Jupiter"
	motto = "Sic itur ad astra"

	ship_prefixes = list("SFI-X" = "a VIP liner", "SFI-L" = "a luxury liner", "SFI-B" = "a business liner", "SFI-E" = "an economy liner", "SFI-M" = "a mixed class liner", "SFI-S" = "a sightseeing", "SFI-M" = "a wedding", "SFI-O" = "a marketing", "SFI-S" = "a safari", "SFI-A" = "an aquatic adventure")
	flight_types = list(		//no military-sounding ones here
			"flight",
			"route",
			"tour"
			)
	ship_names = list(	//birbs
			"Rhea",
			"Ostrich",
			"Cassowary",
			"Emu",
			"Kiwi",
			"Duck",
			"Swan",
			"Chachalaca",
			"Curassow",
			"Guan",
			"Guineafowl",
			"Pheasant",
			"Turkey",
			"Francolin",
			"Loon",
			"Penguin",
			"Grebe",
			"Flamingo",
			"Stork",
			"Ibis",
			"Heron",
			"Pelican",
			"Spoonbill",
			"Shoebill",
			"Gannet",
			"Cormorant",
			"Osprey",
			"Kite",
			"Hawk",
			"Falcon",
			"Caracara"
			)
	destination_names = list(
			"a resort planet",
			"a beautiful ring system",
			"a ski-resort world",
			"an ocean resort planet",
			"a desert resort world",
			"an arctic retreat"
			)

/datum/lore/organization/tsc/oculum
	name = "Oculum Broadcasting Network"
	short_name = "Oculus "
	acronym = "OBN"
	desc = "Oculum owns approximately 30% of Sol-wide news networks, including microblogging aggregate sites, network and comedy news, and even old-fashioned newspapers. Staunchly apolitical, they specialize in delivering the most popular news available- which means telling people what they already want to hear. Oculum is a specialist in branding, and most people don't know that the reactionary Daedalus Dispatch newsletter and the radically transhuman Liquid Steel webcrawler are controlled by the same organization."
	history = ""
	work = "news media"
	headquarters = ""
	motto = "News from all across the spectrum"

	ship_prefixes = list("OBV" = "an investigation", "OBV" = "a distribution", "OBV" = "a journalism", "OBV" = "a general operations")
	destination_names = list(
			"Oculus HQ"
			)

/datum/lore/organization/tsc/centauriprovisions
	name = "Centauri Provisions"
	short_name = "Centauri "
	acronym = "ACP"
	desc = "Headquartered in Alpha Centauri, Centauri Provisions made a name in the snack-food industry primarily by being the first to focus on colonial holdings. The various brands of Centauri snackfoods are now household names, from SkrellSnaks to Space Mountain Wind to the ubiquitous and edible Bread Tube. Their staying power is legendary, and many spacers have grown up on a mix of their cheap crap and protein shakes."
	history = ""
	work = "catering, food, drinks"
	headquarters = "Alpha Centauri"
	motto = "The largest brands of food and drink - most of them are Centauri."

	ship_prefixes = list("CPTV" = "a transport", "CPCV" = "a catering", "CPRV" = "a resupply", "CPV" = "a general operations")
	destination_names = list(
			"Centauri Provisions HQ",
			"a Centauri Provisions depot",
			"a Centauri Provisions warehouse"
			)

/datum/lore/organization/tsc/einstein
	name = "Einstein Engines"
	short_name = "Einstein "
	acronym = "EEN"
	desc = "Einstein is an old company that has survived through rampant respecialization. In the age of phoron-powered exotic engines and ubiquitous solar power, Einstein makes its living through the sale of engine designs for power sources it has no access to and emergency fission or hydrocarbon power supplies. Accusations of corporate espionage against research-heavy corporations like NanoTrasen and its chief rival Focal Point are probably unfounded."
	history = ""
	work = "catering, food, drinks"
	headquarters = ""
	motto = "Engine designs, emergency generators, and old memories"

	ship_prefixes = list("EETV" = "a transport", "EERV" = "a research", "EEV" = "a general operations")
	destination_names = list(
			"Einstein HQ"
			)

/datum/lore/organization/tsc/wulf
	name = "Wulf Aeronautics"
	short_name = "Wulf Aero "
	acronym = "WUFA"
	desc = "Wulf Aeronautics is the chief producer of transport and hauling spacecraft. A favorite contractor of the USG and USDF, Wulf manufactures most of their diplomatic and logistics craft, and does a brisk business with most other TSCs. The quiet reliance of the economy on their craft has kept them out of the spotlight and uninvolved in other corporations' back-room dealings."
	history = ""
	work = "starship construction"
	headquarters = ""
	motto = "We build it - you fly it"

	ship_prefixes = list("WATV" = "a transport", "WARV" = "a repair", "WAV" = "a general operations")
	destination_names = list(
			"Wulf Aeronautics HQ",
			"a Wulf Aeronautics supply depot",
			"a Wulf Aeronautics Shipyard"
			)

/datum/lore/organization/tsc/gilthari
	name = "Gilthari Exports"
	short_name = "Gilthari "
	acronym = "GEX"
	desc = "Gilthari is Sol's premier supplier of luxury goods, specializing in extracting money from the rich and successful. Their largest holdings are in gambling, but they maintain subsidiaries in everything from VR equipment to luxury watches. Their holdings in mass media are a smaller but still important part of their empire. Gilthari is known for treating its positronic employees very well, sparking a number of conspiracy theories. The gorgeous FBP model that Gilthari provides them is a symbol of the corporation's wealth and reach ludicrous prices when available on the black market, with legal ownership of the chassis limited, by contract, to employees."
	history = ""
	work = "luxury goods"
	headquarters = ""
	motto = ""

	ship_prefixes = list("GETV" = "a transport", "GECV" = "a luxury catering", "GEV" = "a general operations")
	//precious stones
	ship_names = list(
			"Afghanite",
			"Agate",
			"Alexandrite",
			"Amazonite",
			"Amber",
			"Amethyst",
			"Ametrine",
			"Andalusite",
			"Aquamarine",
			"Azurite",
			"Benitoite",
			"Beryl",
			"Carnelian",
			"Chalcedony",
			"Chrysoberyl",
			"Chrysoprase",
			"Citrine",
			"Coral",
			"Danburite",
			"Diamond",
			"Emerald",
			"Fluorite",
			"Garnet",
			"Heliodor",
			"Iolite",
			"Jade",
			"Jasper",
			"Lapis Lazuli",
			"Malachite",
			"Moldavite",
			"Moonstone",
			"Obsidian",
			"Onyx",
			"Orthoclase",
			"Pearl",
			"Peridot",
			"Quartz",
			"Ruby",
			"Sapphire",
			"Scapolite",
			"Selenite",
			"Serpentine",
			"Sphalerite",
			"Sphene",
			"Spinel",
			"Sunstone",
			"Tanzanite",
			"Topaz",
			"Tourmaline",
			"Turquoise",
			"Zircon"
			)
	destination_names = list(
			"Gilthari HQ",
			"a GE supply depot",
			"a GE warehouse",
			"a GE-owned luxury resort"
			)

/datum/lore/organization/tsc/coyotecorp
	name = "Coyote Salvage Corp."
	short_name = "Coyote "
	acronym = "CSC"
	desc = "The threat of Kessler Syndrome ever looms in this age of spaceflight, and it's only thanks to the dedication and hard work of unionized salvage groups like the Coyote Salvage Corporation that the spacelanes are kept clear and free of wrecks and debris. Painted in that distinctive industrial yellow, their fleets of roaming scrappers are contracted throughout civilized space and the frontier alike to clean up space debris. Some may look down on them for handling what would be seen as garbage and discarded scraps, but as far as the CSC is concerned everything would grind to a halt (or more accurately, rapidly expand in a cloud of red-hot scrap metal) without their tender care and watchful eyes.\
	<br><br> \
	Many spacers turn to join the ranks of the Salvage Corps when times are lean, or when they need a quick buck. The work is dangerous and the hours are long, but the benefits are generous and you're paid by what you salvage so if you've an eye for appraising scrap you can turn a good profit. For those who dedicate their lives to the work, they can become kings of the scrapheap and live like royalty. \
	<br><br> \
	CSC Contractors are no strangers to conflict either, often having to deal with claimjumpers and illegal salvage operations - or worse, the vox."
	history = ""
	work = "salvage and shipbreaking"
	headquarters = "N/A"
	motto = "one man's trash is another man's treasure"

	ship_prefixes = list("CSV" = "a salvage", "CRV" = "a recovery", "CTV" = "a transport", "CSV" = "a shipbreaking", "CHV" = "a towing")
	//mostly-original, maybe some references, and more than a few puns
	ship_names = list(
			"Road Hog",
			"Mine, Not Yours",
			"Legal Salvage",
			"Barely Legal",
			"One Man's Trash",
			"Held Together By Tape And Dreams",
			"Ventilated Vagrant",
			"Half A Wing And A Prayer",
			"Scrap King",
			"Make Or Break",
			"Lead Into Gold",
			"Under New Management",
			"Pride of Centauri",
			"Long Haul",
			"Argonaut",
			"Desert Nomad",
			"Non-Prophet Organization",
			"Rest In Pieces",
			"Sweep Dreams",
			"Home Sweep Home",
			"Atomic Broom",
			"Ship Broken",
			"Rarely Sober",
			"Barely Coherent",
			"Piece Of Mind",
			"War And Pieces",
			"Bits 'n' Bobs",
			"Home Wrecker",
			"T-Wrecks",
			"Dust Bunny",
			"No Gears No Glory",
			"Three Drinks In",
			"The Almighty Janitor",
			"Wreckless Endangerment",
			"Scarab"
			)
	//remove a couple types, add the more down-to-earth 'job' to reflect some personality
	flight_types = list(
			"job",
			"op",
			"operation",
			"assignment",
			"contract"
			)
	destination_names = list (
			"a frontier scrapyard",
			"a trashbelt",
			"a local salvage yard",
			"a nearby system"
			)

// Other

/datum/lore/organization/other/independent
	name = "Independent Pilots Association"
	short_name = "" //using the same whitespace hack as USDF
	acronym = "IPA"
	desc = "Though less common now than they were in the decades before the Sol Economic Organization took power, independent traders remain an important part of the galactic economy, owing in no small part to protective tariffs established by the Free Trade Union in the late twenty-fourth century. Further out on the frontier, independent pilots are often the only people keeping freight and supplies moving.\
	<br><br> \
	Independent ships use a wide variety of names, many of which are as unusual and eclectic as their crews."
	history = ""
	work = "everything under the sun"
	headquarters = "N/A"
	motto = "N/A"

	ship_prefixes = list("ISV" = "a general", "IEV" = "a prospecting", "IEC" = "a prospecting", "IFV" = "a bulk freight", "ITV" = "a passenger transport", "ITC" = "a just-in-time delivery", "IPV" = "a patrol", "IHV" = "a bounty hunting", "ICC" = "an escort")
	flight_types = list(
			"flight",
			"mission",
			"route",
			"operation",
			"assignment",
			"contract"
			)
	destination_names = list() //we have no hqs or facilities of our own
	//ship names: blank, because we use the universal list

//SPACE LAW
/datum/lore/organization/other/sysdef
	name = "System Defense Force"
	short_name = "" //whitespace hack again
	acronym = "SDF"
	desc = "Localized militias are used to secure systems throughout inhabited space, but are especially common on the frontier; by levying and maintaining these militia forces, larger governments can use their primary fleets (like the USG's USDF) for more important matters and smaller ones can give travellers in their space some peace of mind given the ever-present threat of pirates and vox marauders whilst also helping cut down on smuggling (narcotic substances remain as popular in this century as they have throughout the last few millennia). System Defense Forces tend to be fairly poorly trained and modestly equipped compared to genuine military fleets, but are more than capable of contending with equally ramshackle pirate vessels and can generally stall greater threats long enough for reinforcements to arrive. They're also typically responsible for most search-and-rescue operations in their system.\
	<br><br>\
	SDF ships are traditionally named after various forms of historical weaponry; as their founding members tend to be veterans of other SDF services which used this system, this tradition has slowly propagated.\
	<br><br>\
	Common SDF ship designations include;<br>\
	SDF = System Defense Fleet<br>\
	SDV/SDB = System Defense Vessel/Boat<br>\
	SAR = Search And Rescue (Emergency Services)<br>\
	SDT = System Defense Tender (Mobile Refuel & Resupply)<br>\
	SDJ = Prisoner Transport"
	history = ""
	work = "local security"
	headquarters = ""
	motto = "Serve, Protect, Survive"
	sysdef = TRUE //we're the space law, we don't impersonate people and stuff
	autogenerate_destination_names = FALSE //don't add extra destinations to our pool, or else we leave the system which makes no sense

	ship_prefixes = list ("SDB" = "a patrol", "SDF" = "a patrol", "SDV" = "a patrol", "SDB" = "an escort", "SDF" = "an escort", "SDV" = "an escort", "SAR" = "a search and rescue", "SDT" = "a logistics", "SDT" = "a resupply", "SDJ" = "a prisoner transport") //b = boat, f = fleet (generic), v = vessel, t = tender
	//ship names: weapons
	ship_names = list(
			"Sword",
			"Saber",
			"Cutlass",
			"Broadsword",
			"Katar",
			"Shamshir",
			"Shashka",
			"Epee",
			"Estoc",
			"Longsword",
			"Katana",
			"Baselard",
			"Gladius",
			"Kukri",
			"Pick",
			"Mattock",
			"Hatchet",
			"Machete",
			"Axe",
			"Tomahawk",
			"Dirk",
			"Dagger",
			"Maul",
			"Mace",
			"Flail",
			"Morningstar",
			"Shillelagh",
			"Cudgel",
			"Truncheon",
			"Hammer",
			"Arbalest",
			"Ballista",
			"Catapult",
			"Trebuchet",
			"Longbow",
			"Pike",
			"Javelin",
			"Glaive",
			"Halberd",
			"Scythe",
			"Spear"
			)
	destination_names = list(
			"the outer system",
			"the inner system",
			"Waypoint Alpha",
			"Waypoint Beta",
			"Waypoint Gamma",
			"Waypoint Delta",
			"Waypoint Epsilon",
			"Waypoint Zeta",
			"Waypoint Eta",
			"Waypoint Theta",
			"Waypoint Iota",
			"Waypoint Kappa",
			"Waypoint Lambda",
			"Waypoint Mu",
			"Waypoint Nu",
			"Waypoint Xi",
			"Waypoint Omicron",
			"Waypoint Pi",
			"Waypoint Rho",
			"Waypoint Sigma",
			"Waypoint Tau",
			"Waypoint Upsilon",
			"Waypoint Phi",
			"Waypoint Chi",
			"Waypoint Psi",
			"Waypoint Omega",
			"System Defense Control",
			"an SDF correctional facility",
			"an SDF processing center",
			"an SDF supply depot",
			"an SDF Rapid Response Hub",
			"an SDF outpost"
			)

//basically just a dummy/placeholder 'org' for smuggler events
/datum/lore/organization/other/smugglers
	name = "Smugglers"
	short_name = "" //whitespace hack again
	acronym = "ISC"
	desc = "Where there's a market, there need to be merchants, and where there are buyers, there need to be suppliers. Most of all, wherever there's governments, there'll be somebody trying to control what people are and aren't allowed to do with their bodies. For those seeking goods deemed illegal (for good reasons or otherwise) they need to turn to smugglers and the fine art of sneaking things past the authorities.\
	<br><br>\
	The most common goods smuggled throughout space are narcotics, firearms, and occasionally slaves; whilst firearm ownership laws vary from location to location, most governments also take fairly hard stances on hard drugs, and slavery is consistently outlawed and punished viciously throughout the vast majority of civilized space.\
	<br><br>\
	Still, contrary to many conceptions, not all smuggling is nefarious. Entertainment media within human territories loves to paint romantic images of heroic smugglers sneaking aid supplies to refugees or even helping oppressed minorities escape the grasp of xenophobic regimes."
	history = ""
	work = ""
	headquarters = ""
	motto = ""
	lawful = FALSE //if it wasn't obvious, these guys are usually criminals
	hostile = FALSE //but they're not aggressive ones
	sysdef = FALSE
	autogenerate_destination_names = TRUE //the events we get called for don't fire a destination, but we need entries to avoid runtimes.

	ship_prefixes = list ("suspected smuggler" = "an illegal smuggling", "possible smuggler" = "an illegal smuggling") //as assigned by control, second part shouldn't even come up
	//blank out our shipnames for redesignation
	ship_names = list(
			"Morally Bankrupt",
			"Bucket of Bolts",
			"Wallet Inspector",
			"Laughing Stock",
			"Wayward Son",
			"Wide Load",
			"No Refunds",
			"Ugly Stick",
			"Poetic Justice",
			"Foreign Object",
			"Why Me",
			"Last Straw",
			"Designated Driver",
			"Slapped Together",
			"Lowest Bidder",
			"Harsh Language",
			"Public Servant",
			"Class Act",
			"Deviant Citizen",
			"Diminishing Returns",
			"Calculated Risk",
			"Logistical Nightmare",
			"Gross Negligence",
			"Holier Than Thou",
			"Open Wide",
			"Red Dread",
			"Missing Link",
			"Duct Taped",
			"Robber Baron",
			"Affront to Nature",
			"Total Loss",
			"Depth Perception",
			"This Way",
			"Mysterious Rash",
			"Jolly Roger",
			"Victim of Circumstance",
			"Product of Society",
			"Under Evaluation",
			"Flying Coffin",
			"Gilded Cage",
			"Disgruntled Worker",
			"Of Sound Mind",
			"Ivory Tower",
			"Bastard Son",
			"Scarlet Tentacle",
			"Down In Front",
			"Learning Experience",
			"Desperate Pauper",
			"Born Lucky",
			"Base Instincts",
			"Check Please",
			"Infinite Loop",
			"Lazy Morning",
			"Runtime Error",
			"Pointless Platitude",
			"Grey Matter",
			"Conscientious Objector",
			"Unexplained Itch",
			"Out of Control",
			"Unexpected Obstacle",
			"Toxic Behavior",
			"Controlled Explosion",
			"Happy Camper",
			"Unfortunate Ending",
			"Criminally Insane",
			"Not Guilty",
			"Double Jeopardy",
			"Perfect Pitch",
			"Dark Forecast",
			"Apologies in Advance",
			"Reduced To This",
			"Surprise Encounter",
			"Meat Locker",
			"Cardiac Arrest",
			"Piece of Junk",
			"Bottom Line",
			"With Abandon",
			"Unsound Methods",
			"Beast of Burden",
			"Red Claw",
			"No Laughing Matter",
			"Nothing Personal",
			"Great Experiment",
			"Looks Like Trouble",
			"Turning Point",
			"Murderous Intent",
			"If Looks Could Kill",
			"Liquid Courage",
			"Attention Seeker",
			"Juvenile Delinquent",
			"Mystery Meat",
			"Slippery Slope",
			"Empty Gesture",
			"Annoying Pest",
			"Killing Implement",
			"Blunt Object",
			"Blockade Runner",
			"Innocent Bystander",
			"Lacking Purpose",
			"Beyond Salvation",
			"This Too Shall Pass",
			"Guilty Pleasure",
			"Exploratory Surgery",
			"Inelegant Solution",
			"Under New Ownership",
			"Festering Wound",
			"Red Smile",
			"Mysterious Stranger",
			"Process of Elimination",
			"Prone to Hysteria",
			"Star Beggar",
			"Dream Shatterer",
			"Do The Math",
			"Big Boy",
			"Teacher's Pet",
			"Hell's Bells",
			"Critical Mass",
			"Star Wench",
			"Double Standard",
			"Blind Fury",
			"Carrion Eater",
			"Pound of Flesh",
			"Short Fuse",
			"Road Agent",
			"Deceiving Looks",
			"An Arrow in Flight",
			"Gun-to-Head",
			"Petty Theft",
			"Grand Larceny",
			"Pop Up",
			"A Promise Kept",
			"Frag Machine",
			"Unrepentant Camper",
			"Impersonal Space",
			"Fallen Pillar",
			"Motion Tabled",
			"Outrageous Fortune",
			"Pyrrhic and Proud",
			"Wiggling Bait",
			"Shoot for Loot",
			"Tone Deaf Siren",
			"The Worst Thing",
			"Violence-Liker",
			"Illegal Repercussions",
			"Shameless Plagiarist",
			"Dove & Crow",
			"Barnacle Jim",
			"Charles in Charge",
			"Strange Aeons",
			"Red Queen"
			)
	/*
	destination_names = list(
			)
	*/

/datum/lore/organization/other/pirates
	name = "Pirates"
	short_name = "" //whitespace hack again
	acronym = "IPG"
	desc = "Where there's prey, predators are sure to follow. In space, the prey are civilian merchants, and the predators are opportunistic pirates. This is about where the analogy breaks down, but the basic concept remains the same; civilian ships are usually full of valuable goods or important people, which can be sold on black markets or ransomed back for a healthy sum. Pirates seek to seize the assets of others to get rich, rather than make an honest thaler themselves.\
	<br><br>\
	In contrast to the colorful Ue-Katish and sneaky Vox, common pirates tend to be rough, practical, and brutally efficient in their work. System Defense units practice rapid response drills, and in most systems it's only a matter of minutes before The Law arrives unless the pirate is able to isolate their target and prevent them from sending a distress signal.\
	<br><br>\
	Complicating matters is the infrequent use of privateers by various minor colonial governments, mercenaries turning to piracy during hard times, and illegal salvage operations."
	history = ""
	work = ""
	headquarters = ""
	motto = "What\'s yours is mine."
	lawful = FALSE
	hostile = TRUE
	autogenerate_destination_names = TRUE //the events we get called for don't fire a destination, but we need entries to avoid runtimes.

	ship_prefixes = list ("known pirate" = "a piracy", "suspected pirate" = "a piracy", "rogue privateer" = "a piracy", "Cartel enforcer" = "a piracy", "known outlaw" = "a piracy", "bandit" = "a piracy", "roving corsair" = "a piracy", "illegal salvager" = "an illegal salvage", "rogue mercenary" = "a mercenary") //as assigned by control, second part shouldn't even come up
	ship_names = list(
			"Morally Bankrupt",
			"Bucket of Bolts",
			"Wallet Inspector",
			"Laughing Stock",
			"Wayward Son",
			"Wide Load",
			"No Refunds",
			"Ugly Stick",
			"Poetic Justice",
			"Foreign Object",
			"Why Me",
			"Last Straw",
			"Designated Driver",
			"Slapped Together",
			"Lowest Bidder",
			"Harsh Language",
			"Public Servant",
			"Class Act",
			"Deviant Citizen",
			"Diminishing Returns",
			"Calculated Risk",
			"Logistical Nightmare",
			"Gross Negligence",
			"Holier Than Thou",
			"Open Wide",
			"Red Dread",
			"Missing Link",
			"Duct Taped",
			"Robber Baron",
			"Affront to Nature",
			"Total Loss",
			"Depth Perception",
			"This Way",
			"Mysterious Rash",
			"Jolly Roger",
			"Victim of Circumstance",
			"Product of Society",
			"Under Evaluation",
			"Flying Coffin",
			"Gilded Cage",
			"Disgruntled Worker",
			"Of Sound Mind",
			"Ivory Tower",
			"Bastard Son",
			"Scarlet Tentacle",
			"Down In Front",
			"Learning Experience",
			"Desperate Pauper",
			"Born Lucky",
			"Base Instincts",
			"Check Please",
			"Infinite Loop",
			"Lazy Morning",
			"Runtime Error",
			"Pointless Platitude",
			"Grey Matter",
			"Conscientious Objector",
			"Unexplained Itch",
			"Out of Control",
			"Unexpected Obstacle",
			"Toxic Behavior",
			"Controlled Explosion",
			"Happy Camper",
			"Unfortunate Ending",
			"Criminally Insane",
			"Not Guilty",
			"Double Jeopardy",
			"Perfect Pitch",
			"Dark Forecast",
			"Apologies in Advance",
			"Reduced To This",
			"Surprise Encounter",
			"Meat Locker",
			"Cardiac Arrest",
			"Piece of Junk",
			"Bottom Line",
			"With Abandon",
			"Unsound Methods",
			"Beast of Burden",
			"Red Claw",
			"No Laughing Matter",
			"Nothing Personal",
			"Great Experiment",
			"Looks Like Trouble",
			"Turning Point",
			"Murderous Intent",
			"If Looks Could Kill",
			"Liquid Courage",
			"Attention Seeker",
			"Juvenile Delinquent",
			"Mystery Meat",
			"Slippery Slope",
			"Empty Gesture",
			"Annoying Pest",
			"Killing Implement",
			"Blunt Object",
			"Blockade Runner",
			"Innocent Bystander",
			"Lacking Purpose",
			"Beyond Salvation",
			"This Too Shall Pass",
			"Guilty Pleasure",
			"Exploratory Surgery",
			"Inelegant Solution",
			"Under New Ownership",
			"Festering Wound",
			"Red Smile",
			"Mysterious Stranger",
			"Process of Elimination",
			"Prone to Hysteria",
			"Star Beggar",
			"Dream Shatterer",
			"Do The Math",
			"Big Boy",
			"Teacher's Pet",
			"Hell's Bells",
			"Critical Mass",
			"Star Wench",
			"Double Standard",
			"Blind Fury",
			"Carrion Eater",
			"Pound of Flesh",
			"Short Fuse",
			"Road Agent",
			"Deceiving Looks",
			"An Arrow in Flight",
			"Gun-to-Head",
			"Petty Theft",
			"Grand Larceny",
			"Pop Up",
			"A Promise Kept",
			"Frag Machine",
			"Unrepentant Camper",
			"Impersonal Space",
			"Fallen Pillar",
			"Motion Tabled",
			"Outrageous Fortune",
			"Pyrrhic and Proud",
			"Wiggling Bait",
			"Shoot for Loot",
			"Tone Deaf Siren",
			"The Worst Thing",
			"Violence-Liker",
			"Illegal Repercussions",
			"Shameless Plagiarist",
			"Dove & Crow",
			"Barnacle Jim",
			"Charles in Charge",
			"Strange Aeons",
			"Red Queen"
			)
	/*
	destination_names = list(
			)
	*/

/datum/lore/organization/other/uekatish
	name = "Ue-Katish Pirates"
	short_name = ""
	acronym = "UEK"
	desc = "Contrasting with the Qerr-Glia is a vibrant community of Ue-Katish pirates, who live in cargo flotillas on the edge of Skrellian space (especially on the Human-Skrell border). Ue-Katish ships have no caste system even for the truecaste Skrell and aliens who live there, although they are regimented by rank and role in the ship's functioning. Ue-Katish ships are floating black markets where everything is available for the right price, including some of the galaxy's most well-connected information brokers and most skilled guns-for-hire. The Ue-Katish present the greatest Skrellian counterculture and feature heavily in romanticized human media, although at their hearts they are still bandits and criminals, and the black markets are filled with goods plundered from human and Skrellian trade ships. Many of the Ue-Katish ships themselves bear the scars of the battle that brought them under the pirate flag.\
	<br><br> \
	Ue-Katish pirate culture is somewhat similar to many human countercultures, gleefully reclaiming slurs and subverting expectations for the sheer shock value. Nonetheless, Ue-Katish are still Skrell, and still organize in neat hierarchies under each ship's Captain. The Captain's word is absolute, and unlike the Qerr-Katish they lack any sort of anti-corruption institutions."
	history = ""
	work = ""
	motto = ""
	lawful = FALSE
	hostile = TRUE
	autogenerate_destination_names = TRUE

	ship_prefixes = list("Ue-Katish pirate" = "a raiding", "Ue-Katish bandit" = "a raiding", "Ue-Katish raider" = "a raiding", "Ue-Katish enforcer" = "an enforcement")
	ship_names = list(
			"Keqxuer'xeu's Prize",
			"Xaeker'qux' Bounty",
			"Teq'ker'qerr's Mercy",
			"Ke'teq's Thunder",
			"Xumxerr's Compass",
			"Xue'qux' Greed",
			"Xaexuer's Slave",
			"Xue'taq's Dagger",
			"Teqxae's Madness",
			"Taeqtaq'kea's Pride",
			"Keqxae'xeu's Saber",
			"Xueaeq's Disgrace",
			"Xum'taq'qux' Star",
			"Ke'xae'xe's Scream",
			"Keq'keax' Blade"
			)

/datum/lore/organization/other/marauders
	name = "Vox Marauders"
	short_name = "" //whitespace hack again
	acronym = "VOX"
	desc = "Whilst rarely as directly threatening as 'common' pirates, the phoron-breathing vox nevertheless pose a constant nuisance for shipping; as far as vox are concerned, only vox and vox matters matter, and everyone else is a 'treeless dustlung'. Unlike sometimes over-confident pirates, the vox rarely engage in open combat, preferring to steal and raid through stealth rather than brute force. Vox raiders will only commit to an attack if they're confident that they can quickly overwhelm and subdue their victims, then swiftly get away in the event that any alarms are tripped or reinforcements are called for.\
	<br><br>\
	As Vox ship names are generally impossible for the vast majority of other species to pronounce, System Defense tends to tag marauders with a designation based on the ancient NATO Phonetic Alphabet."
	history = "Unknown"
	work = "Looting and raiding"
	headquarters = "Nowhere"
	motto = "(unintelligible screeching)"
	lawful = FALSE
	hostile = TRUE
	autogenerate_destination_names = TRUE //the events we get called for don't fire a destination, but we need *some* entries to avoid runtimes.

	ship_prefixes = list("vox marauder" = "a marauding", "vox raider" = "a raiding", "vox ravager" = "a raiding", "vox corsair" = "a raiding") //as assigned by control, second part shouldn't even come up
	//blank out our shipnames for redesignation
	ship_names = list(
			)
	/*
	destination_names = list(
			)
	*/

/datum/lore/organization/other/marauders/New()
	..()
	var/i = 20 //give us twenty random names, marauders get tactical designations from SDF
	var/list/letters = list(
			"Alpha",
			"Bravo",
			"Charlie",
			"Delta",
			"Echo",
			"Foxtrot",
			"Golf",
			"Hotel",
			"India",
			"Juliett",
			"Kilo",
			"Lima",
			"Mike",
			"November",
			"Oscar",
			"Papa",
			"Quebec",
			"Romeo",
			"Sierra",
			"Tango",
			"Uniform",
			"Victor",
			"Whiskey",
			"X-Ray",
			"Yankee",
			"Zulu"
			)
	var/list/numbers = list(
			"Zero",
			"One",
			"Two",
			"Three",
			"Four",
			"Five",
			"Six",
			"Seven",
			"Eight",
			"Nine"
			)
	while(i)
		ship_names.Add("[pick(letters)]-[pick(numbers)]")
		i--

// Governments

/datum/lore/organization/gov/solgov
	name = "United Solar Government"
	short_name = "SolGov "
	acronym = "USG"
	desc = "The Unified Solar Government, or just \'SolGov\' to most, is a decentralized confederation of human governmental entities based on Luna, Sol, which defines top-level law for their member states. Member states receive various benefits such as defensive pacts, trade agreements, social support and funding, and being able to participate in the Colonial Assembly. The majority of human territories are members of SolGov, though there are notable groups who refuse to participate. As such, SolGov is a major power and defacto represents humanity on the galactic stage.\
	<br><br> \
	Ships on USG assignments typically carry the designations of Earth\'s largest craters, as a reminder of everything the planet has endured."
	history = "" // Todo
	work = "governing polity of humanity's Confederation"
	headquarters = "Luna, Sol"
	motto = "Nil Mortalibus Ardui Est" // Latin, because latin.  Says 'Nothing is too steep for mortals'
	autogenerate_destination_names = TRUE

	ship_prefixes = list("USG-A" = "an administrative", "USG-T" = "a transportation", "USG-D" = "a diplomatic", "USG-F" = "a freight", "USG-J" = "a prisoner transfer")
	//earth's biggest impact craters
	ship_names = list(
			"Wabar",
			"Kaali",
			"Campo del Cielo",
			"Henbury",
			"Morasko",
			"Boxhole",
			"Macha",
			"Rio Cuarto",
			"Ilumetsa",
			"Tenoumer",
			"Xiuyan",
			"Lonar",
			"Agoudal",
			"Tswaing",
			"Zhamanshin",
			"Bosumtwi",
			"Elgygytgyn",
			"Bigach",
			"Karla",
			"Karakul",
			"Vredefort",
			"Chicxulub",
			"Sudbury",
			"Popigai",
			"Manicougan",
			"Acraman",
			"Morokweng",
			"Kara",
			"Beaverhead",
			"Tookoonooka",
			"Charlevoix",
			"Siljan Ring",
			"Montagnais",
			"Araguinha",
			"Chesapeake",
			"Mjolnir",
			"Puchezh-Katunki",
			"Saint Martin",
			"Woodleigh",
			"Carswell",
			"Clearwater West",
			"Clearwater East",
			"Manson",
			"Slate",
			"Yarrabubba",
			"Keurusselka",
			"Shoemaker",
			"Mistastin",
			"Kamensk",
			"Steen",
			"Strangways",
			"Tunnunik",
			"Boltysh",
			"Nordlinger Ries",
			"Presqu'ile",
			"Haughton",
			"Lappajarvi",
			"Rochechouart",
			"Gosses Bluff",
			"Amelia Creek",
			"Logancha",
			"Obolon'",
			"Nastapoka",
			"Ishim",
			"Bedout"
			)
	destination_names = list(
			"Venus",
			"Earth",
			"Luna",
			"Mars",
			"Titan",
			"Europa",
			"the Jovian subcluster",
			"a SolGov embassy",
			"a classified location"
			)
			// autogen will add a lot of other places as well.

/datum/lore/organization/gov/almachi
	name = "Almach Association"
	short_name = "Almachi "
	acronym = "ALM"
	desc = "The Almach Association, or Almach, is a Mercurial governmental entity with major population centers in Shelf, Angessa's Pearl, Vounna, and Relan, and extending throughout the nearby region.\
	<br><br> \
	Almach is primarily a military union designed to protect the constituent systems from an attack by SolGov, although some argue that it gives large constituents an unacceptable level of influence over their neighbors. Almach also conducts shared trade and diplomacy missions, but differs from a confederacy by its lack of legislative powers. All contributions to the Association are voluntary. Most constituent systems are organized as direct democracies, although it also counts workers' unions, republics and even theocracies among its members.\
	<br><br> \
	Almach's military forces are given broad autonomy to respond to unfolding situations as they will, with a heavily decentralized strategic model unique to the Mercurial government."
	history = ""
	work = ""
	headquarters = "Shelf, Angessa's Pearl, Vounna, and Relan"
	motto = ""
	autogenerate_destination_names = TRUE

	ship_prefixes = list("ALM-A" = "an administrative", "ALM-T" = "a transportation", "ALM-D" = "a diplomatic", "ALM-F" = "a freight", "ALM-J" = "a prisoner transfer")
	//TODO: better ship names
	/*
	ship_names = list(
			"",
			)
	*/
	destination_names = list(
			"an Association member colony",
			"the Xia subcluster",
			"the Matigab subcluster",
			"the Zegev subcluster",
			"|Prometheus| Station, Vounna",
			"an Association embassy",
			"a classified location"
			)

/* setup for tajaran + other xeno groups, but allakai never came forth with useful resources for me. leaving my framework in place for later updating.
/datum/lore/organization/gov/alarjir_iniye
	name = "Alarjir Iniye"
	short_name = "Coalition "
	acronym = "ALI"
	desc = "The Alarjir Iniye, or Pearlshield Coalition, is a tenuous alliance of several tajaran nations and other groups who seek to solidify their people's hold on the few territories they presently hold. Whilst externally fairly well-organzed, the Coalition is internally a hotbed of intrigue and competition."
	history = ""
	work = ""
	headquarters = "Rarkajar"
	motto = ""
	autogenerate_destination_names = FALSE //big list of own holdings to come

	ship_prefixes = list("ALI-A" = "an administrative", "ALI-D" = "a diplomatic", "ALI-M" = "a peacekeeping", "ALI-F" = "a transportation", "ALI-J" = "a prisoner transfer", "ALI-R" = "a research")
	//TODO: better ship names
	ship_names = list(
			"",
			)
	destination_names = list(
			"Rarkajar, Meralar",
			"a Coalition outpost in Meralar",
			"a Coalition shipyard",
			"a Coalition supply depot",
			"a Coalition embassy",
			"a Coalition research base",
			"Alar-Selna, Arrakthiir",
			"a minor colony in Arrakthiir",
			"a Coalition outpost in Arrakthiir",
			"a tajaran colony in Mesomori",
			"a Coalition outpost in Mesomori",
			"a mining base in Mesomori"
			)

/datum/lore/organization/gov/unathi
	name = "Moghes Hegemony"
	short_name = "Hegemony "
	acronym = "MGH"
	desc = ""
	history = ""
	work = ""
	headquarters = "Moghes"
	motto = ""
	autogenerate_destination_names = FALSE //big list of own holdings to come

	ship_prefixes = list("MGH-D" = "a diplomatic", "MGH-U" = "a Unity-mandated", "MGH-M" = "a peacekeeping", "MGH-F" = "a transportation", "MGH-J" = "a prisoner transfer", "MGH-R" = "a Redemptionist")
	//TODO: better ship names
	ship_names = list(
			"",
			)
	destination_names = list(
			"Moghes, Uueoa-Esa",
			"Kharet, Uueoa-Esa",
			"a gas-mining facility over Yeora",
			"a mining outpost in the Yoos belt",
			"a Hegemony resuply depot",
			"a Hegemony shipyard",
			"a Hegemony embassy",
			"a Hegemony outpost near Abel's Rest"
			)
*/

/datum/lore/organization/gov/teshari
	name = "Teshari Expeditionary Fleet"
	short_name = "Teshari Expeditionary "
	acronym = "TEF"
	desc = "Though nominally a client state of the skrell, the teshari nevertheless maintain their own navy in the form of the Teshari Expeditionary Fleet. The TEF are as much civil and combat engineers as a competent space force, as they are the tip of the spear when it comes to locating and surveying new worlds suitable for teshari habitation, and in the establishment of full colonies. That isn't to say there aren't independent teshari colonies out there, but those that are founded under the wings of the TEF tend to be the largest and most prosperous. They're also responsible for maintaining the security of these colonies and protecting trade ships. Like the USDF (and unlike most other governmental fleets), TEF vessels almost universally sport the 'TEF' designator rather than specific terms.\
	<br><br>\
	The TEF's ships are named after famous teshari pioneers and explorers and the events surrounding those individuals."
	history = ""
	work = "teshari colonization and infrastructure maintenance"
	headquarters = "Qerr'balak, Qerr'valis"
	motto = ""
	autogenerate_destination_names = TRUE //big list of own holdings to come

	//the tesh expeditionary fleet's closest analogue in modern terms would be the US Army Corps of Engineers, just with added combat personnel as well
	ship_prefixes = list("TEF" = "a diplomatic", "TEF" = "a peacekeeping", "TEF" = "an escort", "TEF" = "an exploration", "TEF" = "a survey", "TEF" = "an expeditionary", "TEF" = "a pioneering")
	//TODO: better ship names. I just took a bunch of random teshnames from the Random Name button and added a word.
	ship_names = list(
			"Leniri's Hope",
			"Tatani's Venture",
			"Ninai's Voyage",
			"Miiescha's Claw",
			"Ishena's Talons",
			"Lili's Fang",
			"Taalische's Wing",
			"Cami's Pride",
			"Schemisa's Glory",
			"Shilirashi's Wit",
			"Sanene's Insight",
			"Aeimi's Wisdom",
			"Ischica's Mind",
			"Recite's Cry",
			"Leseca's Howl",
			"Iisi's Fury",
			"Simascha's Revenge",
			"Lisascheca's Vengeance"
			)
	destination_names = list(
			"an Expeditionary Fleet RV point",
			"an Expeditionary Fleet Resupply Ship",
			"an Expeditionary Fleet Supply Depot",
			"a newly-founded Teshari colony",
			"a prospective Teshari colony site",
			"a potential Teshari colony site",
			"Expeditionary Fleet HQ"
			)

// Military
// Used for Para-Military groups right now! Pair of placeholder-ish PMCs.

/datum/lore/organization/mil/usdf
	name = "United Solar Defense Force"
	short_name = "" //Doesn't cause whitespace any more, with a little sneaky low-effort workaround
	acronym = "USDF"
	desc = "The USDF is the dedicated military force of the USG, originally formed by the United Nations. USDF ships are responsible for securing the major traffic lanes between USG member systems, as well as protecting them from threats that are too great for local SDF units to handle. A lot of dubious incidents and several notable firebrands within the USDF mean that the USDF is considered by some to be the galaxy\'s eight-hundred-pound gorilla; it does whatever it wants whenever it wants, and there really isn\'t anything you can do about it. Thankfully, a coalition of moderates and USG loyalists has managed to keep things together, for the time being."
	history = ""
	work = "peacekeeping and piracy suppression"
	headquarters = "Paris, Earth"
	motto = "Si Vis Pacem Para Bellum" //if you wish for peace, prepare for war
	autogenerate_destination_names = TRUE

	ship_prefixes = list ("USDF" = "a logistical", "USDF" = "a training", "USDF" = "a patrol", "USDF" = "a piracy suppression", "USDF" = "a peacekeeping", "USDF" = "a relief", "USDF" = "an escort", "USDF" = "a search and rescue", "USDF" = "a classified")
	flight_types = list(
			"mission",
			"operation",
			"exercise",
			"assignment",
			"deployment"
			)
	ship_names = list(
			"Aphrodite",
			"Apollo",
			"Ares",
			"Artemis",
			"Athena",
			"Demeter",
			"Dionysus",
			"Hades",
			"Hephaestus",
			"Hera",
			"Hermes",
			"Hestia",
			"Poseidon",
			"Zeus",
			"Achlys",
			"Aether",
			"Aion",
			"Ananke",
			"Chaos",
			"Chronos",
			"Erebus",
			"Eros",
			"Gaia",
			"Hemera",
			"Hypnos",
			"Nemesis",
			"Nyx",
			"Phanes",
			"Pontus",
			"Tartarus",
			"Thalassa",
			"Thanatos",
			"Uranus",
			"Coeus",
			"Crius",
			"Cronus",
			"Hyperion",
			"Iapetus",
			"Mnemosyne",
			"Oceanus",
			"Phoebe",
			"Rhea",
			"Tethys",
			"Theia",
			"Themis",
			"Asteria",
			"Astraeus",
			"Atlas",
			"Aura",
			"Clymene",
			"Dione",
			"Helios",
			"Selene",
			"Eos",
			"Epimetheus",
			"Eurybia",
			"Eurynome",
			"Lelantos",
			"Leto",
			"Menoetius",
			"Metis",
			"Ophion",
			"Pallas",
			"Perses",
			"Prometheus",
			"Styx"
			)
	destination_names = list(
			"USDF HQ",
			"a USDF staging facility on the edge of USG territory",
			"a USDF supply depot",
			"a USDF rally point",
			"a USDF forward base",
			"a USDF repair facility",
			"a USDF shipyard in Sol",
			"a classified location"
			)

/datum/lore/organization/mil/almachivanguard
	name = "Almach Revolutionary Vanguard"
	short_name = "Vanguard "
	acronym = "ARV"
	desc = "The Association Fleet is a metaphorical knife to be aimed at SolGov at all times. Contributed to and commanded by constituent interests, the elements of the Fleet vary wildly in composition, construction, and doctrine. Generally, the Association has adopted more unconventional tactics in their standing doctrine than the USDF, a necessity given the minescule size of their fleet and population compared to the latter. While sometimes deployed to protect trade convoys from the heavy Vox presence in the uninhabited region between the Rim and the outer Skrell colonies, the Fleet's primary purpose is discouraging a direct attack from any who might covet the Association's holdings."
	history = ""
	work = "Almach Association Security"
	headquarters = "Classified"
	motto = ""
	autogenerate_destination_names = TRUE
	complex_tasks = TRUE

	ship_prefixes = list("AFV" = "a formalist", "ATV" = "a telops", "AAV" = "an ascendancy")
	flight_types = list(
			"mission",
			"operation",
			"exercise",
			"assignment",
			"deployment"
			)
	ship_names = list(
			"Bulwark of the Free",
			"Dawnstar",
			"Fiery Justice",
			"Freedom",
			"Gauntlet",
			"Hero of the Revolution",
			"Liberty",
			"Memory of the Fallen",
			"People's Fist",
			"Pride of Liberty",
			"Star of Tiamat",
			"Torch of Freedom",
			"Vanguard's Defiance",
			"Transhumanist",
			"Beacon of Progress"
			)
	destination_names = list(
			"a Vanguard resupply hub",
			"a Vanguard staging facility on the edge of Association territory",
			"an Association colony in need of assistance",
			"a Vanguard supply depot",
			"a Vanguard taskforce",
			"a Vanguard rally point",
			"a Vanguard forward base",
			"a Vanguard vac-dock",
			"a Vanguard repair facility",
			"a classified location"
			)

/datum/lore/organization/mil/pcrc
	name = "Proxima Centauri Risk Control"
	short_name = "Proxima Centauri "
	acronym = "PCRC"
	desc = "Not a whole lot is known about the private security company known as PCRC, but it is known that they're irregularly contracted by the larger TSCs for certain delicate matters. Much of the company's inner workings are shrouded in mystery, and most citizens have never even heard of them. They enjoy fairly good PR for a private security group, especially when compared to SAARE."
	history = ""
	work = "risk control and private security"
	headquarters = "Proxima Centauri"
	motto = ""
	autogenerate_destination_names = TRUE

	ship_prefixes = list("PCRC" = "a risk control", "PCRC" = "a private security")
	flight_types = list(
			"flight",
			"mission",
			"route",
			"operation",
			"assignment",
			"contract"
			)
	//law/protection terms
	ship_names = list(
			"Detective",
			"Constable",
			"Judge",
			"Adjudicator",
			"Magistrate",
			"Marshal",
			"Warden",
			"Peacemaker",
			"Arbiter",
			"Justice",
			"Order",
			"Jury",
			"Inspector",
			"Bluecoat",
			"Gendarme",
			"Gumshoe",
			"Patrolman",
			"Sentinel",
			"Shield",
			"Aegis",
			"Auditor",
			"Monitor",
			"Investigator",
			"Agent",
			"Prosecutor",
			"Sergeant"
			)

	destination_names = list(
			"PCRC HQ, in Proxima Centauri",
			"a PCRC training installation",
			"a PCRC supply depot"
			)

//I'm covered in beeeeeeees!
/datum/lore/organization/mil/hive
	name = "HIVE Security"
	short_name = "HIVE "
	acronym = "HVS"
	desc = "HIVE Security is a merging of several much smaller freelance companies, and operates throughout civilized space. Unlike some companies, it operates no planetside facilities whatsoever, opting instead for larger flotillas that are serviced by innumerable smallcraft. As with any PMC there's no small amount of controversy surrounding them, but they try to keep their operations cleaner than their competitors. They're fairly well known for running 'mercy' operations, which are low-cost no-strings-attached contracts for those in dire need."
	history = ""
	work = "mercenary contractors"
	headquarters = ""
	motto = "Strength in Numbers"
	autogenerate_destination_names = TRUE

	ship_prefixes = list("HPF" = "a secure freight", "HPT" = "a training", "HPS" = "a logistics", "HPV" = "a patrol", "HPH" = "a bounty hunting", "HPX" = "an experimental", "HPC" = "a command", "HPI" = "a mercy")
	flight_types = list(
			"flight",
			"mission",
			"route",
			"operation",
			"assignment",
			"contract"
			)
	//animals, preferably predators, all factual/extant critters
	ship_names = list(
			"Wolf",
			"Bear",
			"Eagle",
			"Condor",
			"Falcon",
			"Hawk",
			"Kestrel",
			"Shark",
			"Fox",
			"Weasel",
			"Mongoose",
			"Bloodhound",
			"Rhino",
			"Tiger",
			"Leopard",
			"Panther",
			"Cheetah",
			"Lion",
			"Vulture",
			"Piranha",
			"Crocodile",
			"Alligator",
			"Recluse",
			"Tarantula",
			"Scorpion",
			"Orca",
			"Coyote",
			"Jackal",
			"Hyena",
			"Hornet",
			"Wasp",
			"Sealion",
			"Viper",
			"Cobra",
			"Sidewinder",
			"Asp",
			"Python",
			"Anaconda",
			"Krait",
			"Diamondback",
			"Mamba",
			"Fer de Lance",
			"Keelback",
			"Adder",
			"Constrictor",
			"Boa",
			"Moray",
			"Taipan",
			"Rattlesnake"
			)
	destination_names = list(
			"the HIVE Command fleet",
			"a HIVE patrol fleet",
			"a HIVE flotilla",
			"a HIVE training fleet",
			"a HIVE logistics fleet"
			)
			//some basics, padded with autogen

//replaced the edgy blackstar group with polaris-canon SAARE
/datum/lore/organization/mil/saare
	name = "Stealth Assault Enterprises"
	short_name = ""
	acronym = "SAARE"
	desc = "SAARE consistently have the worst reputation of any paramilitary group. This is because they specialize in deniability and secrecy. Although publically they work in asset recovery, they have a substantiated reputation for info-theft and piracy that has lead to them butting heads with the law on more than one occasion. Nonetheless, they are an invaluable part of the Solar economy, and other TSCs and small colonial governments keep them in business.\
	<br><br>\
	For the purposes of plausible deniability, SAARE designates their ships using a series of rotating identifiers, with ships on a specific operation or in a particular area all using the same initial designation (" + span_italics("e.g.") + " 'Sledgehammer') and having a different numerical identifier, with the most important ships involved bearing a unique additional codename (such as 'Actual' for Command & Control ships). As ships are shuffled in and out of operating areas, it can be difficult to pin down exactly which ship in SAARE's fleet was responsible for which act. SAARE's misdirection is multilayered, including elements such as extensive use of repainting, false IFFs, bribes, forged documents, intimidation, camouflage, and all manner of other underhanded tactics."
	history = ""
	work = "mercenary contractors"
	headquarters = ""
	motto = "Aut Neca Aut Necare"
	autogenerate_destination_names = TRUE

	ship_prefixes = list("SAARE" = "a secure freight", "SAARE" = "a training", "SAARE" = "a logistics", "SAARE" = "a patrol", "SAARE" = "a security", "SAARE" = "an experimental", "SAARE" = "a command", "SAARE" = "a classified")
	flight_types = list(
			"flight",
			"mission",
			"route",
			"operation",
			"assignment",
			"contract"
			)
	ship_names = list()
	destination_names = list(
			"SAARE Command",
			"a SAARE training site",
			"a SAARE logistical depot",
			"a SAARE-held shipyard"
			)

/datum/lore/organization/mil/saare/New()
	..()
	var/i = 20 //give us twenty random names, saare uses tacticool designations
	var/list/letters = list(
			"King",
			"Queen",
			"Duke",
			"Cipher",
			"Monarch",
			"Marshal",
			"Magnum",
			"Longbow",
			"Jupiter",
			"Excalibur",
			"Charon",
			"Bloodhound",
			"Daybreak",
			"Tomahawk",
			"Raptor",
			"Cerberus",
			"Apollo",
			"Firebird",
			"Outlaw",
			"Outrider",
			"Vector",
			"Spearhead",
			"Sledgehammer",
			"Typhon",
			"Sundown",
			"Zodiac",
			"Colossus",
			"Jackhammer",
			"Kodiak",
			"Phalanx",
			"Rainmaker",
			"Shockwave",
			"Warhammer",
			"Crusader",
			"Maverick",
			"Nighthawk",
			"Redshift",
			"Challenger",
			"Starlight",
			"Sunray",
			"Ironside",
			"Holdfast",
			"Foxhound"
			)
	var/list/numbersone = list(
			"Zero",
			"One",
			"Two",
			"Three",
			"Four",
			"Five",
			"Six",
			"Seven",
			"Eight",
			"Nine"
			)
	var/list/numberstwo = list(
			"Zero",
			"One",
			"Two",
			"Three",
			"Four",
			"Five",
			"Six",
			"Seven",
			"Eight",
			"Niner"
			)
	while(i)
		ship_names.Add("[pick(letters)] [pick(40;"Actual","[pick(numbersone)]-[pick(numberstwo)]")]")
		i--

	//ex: "Phalanx One-Niner", "Sledgehammer Actual" (CO/VIP), "Kodiak Seven-Four", "Tomahawk Two-Zero"
	//probably a more elegant (read: fancier) way to do the second part but fuck it, this works just fine

/datum/lore/organization/gov/altevian_hegemony
	name = "The Altevian Hegemony"
	short_name = "Altevian Hegemony "
	acronym = "AH"
	desc = "The Altevians are a space-faring race of rodents that resemble Earth-like rats. They do not have a place they call home in terms of a planet, and instead have massive multiple-kilometer-long colony-ships that are constantly on the move and typically keep operations outside of known populated systems to not eat the resources from others. Their primary focus is trade and slavage operations and can be expected to be seen around both densely populated and empty systems for their work."
	history = ""
	work = "salvage and trade operators"
	headquarters = "AH-CV Migrant"
	motto = ""

	ship_prefixes = list("AH-DV" = "a diplomatic", "AH-EV" = "an exploration", "AH-FV" = "a fueling", "AH-FV" = "a cargo", "AH-SV" = "a research", "AH-TV" = "a colony-transporter", "AH-RV" = "an emergency response", "AH-RV" = "a response", "AH-MV" = "a medical")
	// Diona names
	ship_names = list(
			"Platinum",
			"Warson",
			"Mane",
			"Holland",
			"Arauz",
			"Diamond",
			"Gold",
			"Steam",
			"Boiler",
			"Slip",
			"Lavender",
			"Wheel",
			"Stuntson",
			"Desto",
			"Palos",
			"Matterson",
			"Mill",
			"Smoke",
			"Squeakson",
			"Rabion",
			"Strikedown",
			"Cluster",
			"Ratling",
			"Archaeologist",
			"Beaker",
			"Petal",
			"Gantry"
			)
	destination_names = list(
			"the AH-CV Migrant flagship",
			"one of our research colony-ships",
			"the AH-CV Lotus",
			"the AH-CV Anvil",
			"the AH-CV Generations",
			"the AH-CV Galley",
			"the AH-CV Prosperity",
			"the AH-CV Kitsap",
			"the AH-CV Diamondback",
			"one of our colony-ships",
			"one of our production fleets",
			"a trade fleet",
			)
