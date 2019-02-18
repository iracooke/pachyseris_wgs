
# ids_to_pops <- c("DC1105"="C3",
#                    "DC1107"="C2",
#                    "DC1108"="C2",
#                    "DC1109"="C3",
#                    "DC7955"="C3",
#                    "DC7957"="C3",
#                    "DC7962"="C2",
#                    "DC7967"="C1",
#                    "DC7968"="C2",
#                    "DC7969"="C1")
#   ids_to_locations <- c("DC1105"="Myr",
#                         "DC1107"="Myr",
#                         "DC1108"="Myr",
#                         "DC1109"="Myr",
#                         "DC7955"="GD",
#                         "DC7957"="GD",
#                         "DC7962"="GD",
#                         "DC7967"="GD",
#                         "DC7968"="GD",
#                         "DC7969"="GD")
# echo "BEGIN TRAITS;
# 	Dimensions NTRAITS=6;
# 	Format labels=yes missing=? separator=Comma;
# 	TraitLabels C1 C2 C3 Myr GD Rib;
# 	Matrix
# 	DC1104 1,0,0,1,0,0
# 	DC1105 0,0,1,1,0,0
# 	DC1107 0,1,0,1,0,0
# 	DC1108 0,1,0,1,0,0
# 	DC1109 0,0,1,1,0,0
# 	DC7955 0,0,1,0,1,0
# 	DC7957 0,0,1,0,1,0
# 	DC7958 0,0,1,0,1,0
# 	DC7962 0,1,0,0,1,0
# 	DC7967 1,0,0,0,1,0
# 	DC7968 0,1,0,0,1,0
# 	DC7969 1,0,0,0,1,0
# 	DC8218 1,0,0,0,0,1
# 	DC8220 0,1,0,0,0,1
# 	DC8222 0,0,1,0,0,1
# 	DC8223 0,0,1,0,0,1
# 	DC8229 0,1,0,0,0,1
# 	DC8230 1,0,0,0,0,1
# 	DC8235 1,0,0,0,0,1
# 	DC8238 0,0,1,0,0,1
# 	;
# 	END;
# 	"


echo "BEGIN TRAITS;
	Dimensions NTRAITS=3;
	Format labels=yes missing=? separator=Comma;
	TraitLabels C1 C2 C3;
	Matrix
	DC1104 1,0,0
	DC1105 0,0,1
	DC1107 0,1,0
	DC1108 0,1,0
	DC1109 0,0,1
	DC7955 0,0,1
	DC7957 0,0,1
	DC7958 0,0,1
	DC7962 0,1,0
	DC7967 1,0,0
	DC7968 0,1,0
	DC7969 1,0,0
	DC8218 1,0,0
	DC8220 0,1,0
	DC8222 0,0,1
	DC8223 0,0,1
	DC8229 0,1,0
	DC8230 1,0,0
	DC8235 1,0,0
	DC8238 0,0,1
	;
	END;
	"
