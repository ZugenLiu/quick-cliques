
BUILD_DIR = build
SRC_DIR   = src
BIN_DIR   = bin

CFLAGS = -Winline -O2 -std=c++11 -g

SOURCES_TMP += Isolates.cpp
SOURCES_TMP += Isolates2.cpp
SOURCES_TMP += ExperimentalReduction.cpp
SOURCES_TMP += IndependentSetsReduction.cpp
SOURCES_TMP += Staging.cpp
SOURCES_TMP += CliqueTools.cpp
SOURCES_TMP += GraphTools.cpp
SOURCES_TMP += DegeneracyIndependentSets2.cpp
SOURCES_TMP += MaximalCliqueAlgorithm.cpp
SOURCES_TMP += MinimumCliqueAlgorithm.cpp
SOURCES_TMP += ReverseDegeneracyVertexSets.cpp
SOURCES_TMP += CliqueGraphAlgorithm.cpp
SOURCES_TMP += PartialMatchGraph.cpp
SOURCES_TMP += PartialMatchDegeneracyVertexSets.cpp
SOURCES_TMP += DegeneracyIndependentSets.cpp
SOURCES_TMP += MaximumCliqueAlgorithm.cpp
SOURCES_TMP += IndependentSets.cpp
SOURCES_TMP += CacheEfficientDegeneracyVertexSets.cpp
SOURCES_TMP += DegeneracyVertexSets.cpp
SOURCES_TMP += AdjacencyListVertexSets.cpp
SOURCES_TMP += BronKerboschAlgorithm.cpp
SOURCES_TMP += MemoryManager.cpp
SOURCES_TMP += Algorithm.cpp
SOURCES_TMP += TomitaAlgorithm.cpp
SOURCES_TMP += AdjacencyListAlgorithm.cpp
SOURCES_TMP += TimeDelayAdjacencyListAlgorithm.cpp
SOURCES_TMP += TimeDelayMaxDegreeAlgorithm.cpp
SOURCES_TMP += TimeDelayDegeneracyAlgorithm.cpp
SOURCES_TMP += HybridAlgorithm.cpp
SOURCES_TMP += DegeneracyAlgorithm.cpp
SOURCES_TMP += FasterDegeneracyAlgorithm.cpp
SOURCES_TMP += DegeneracyTools.cpp
SOURCES_TMP += Tools.cpp

SOURCES=$(addprefix $(SOURCES_DIR)/, $(SOURCES_TMP))

OBJECTS_TMP=$(SOURCES_TMP:.cpp=.o)
OBJECTS=$(addprefix $(BUILD_DIR)/, $(OBJECTS_TMP))

DEPFILES_TMP:=$(SOURCES_TMP:.cpp=.d)
DEPFILES=$(addprefix $(BUILD_DIR)/, $(DEPFILES_TMP))

EXEC_NAMES = printnm compdegen qc

EXECS = $(addprefix $(BIN_DIR)/, $(EXEC_NAMES))

#DEFINE += -DDEBUG       #for debugging
#DEFINE += -DMEMORY_DEBUG #for memory debugging.
#DEFINE += -DRETURN_CLIQUES_ONE_BY_ONE 
#DEFINE += -DPRINT_CLIQUES_ONE_BY_ONE 

#DEFINE += -DPRINT_CLIQUES_TOMITA_STYLE # used by Eppstein and Strash (2011)

#some systems handle malloc and calloc with 0 bytes strangely.
DEFINE += -DALLOW_ALLOC_ZERO_BYTES# used by Eppstein and Strash (2011) 

VPATH = src

.PHONY : all

all: $(EXECS)

.PHONY : clean

clean: 
	rm -rf $(EXECS) $(BUILD_DIR) $(BIN_DIR)

$(BIN_DIR)/printnm: printnm.cpp ${OBJECTS} | ${BIN_DIR}
	g++ ${DEFINE} ${OBJECTS} $(SRC_DIR)/printnm.cpp -o $@

$(BIN_DIR)/compdegen: compdegen.cpp ${OBJECTS} | ${BIN_DIR}
	g++ $(CFLAGS) ${DEFINE} ${OBJECTS} $(SRC_DIR)/compdegen.cpp -o $@

$(BIN_DIR)/qc: main.cpp ${OBJECTS} | ${BIN_DIR}
	g++ $(CFLAGS) ${DEFINE} ${OBJECTS} $(SRC_DIR)/main.cpp -o $@

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp $(SRC_DIR)/%.h $(BUILD_DIR)/%.d | $(BUILD_DIR)
	g++ $(CFLAGS) ${DEFINE} -c $< -o $@

$(BUILD_DIR)/%.d: $(SRC_DIR)/%.cpp | $(BUILD_DIR)
	g++ $(CFLAGS) -MM -MT '$(patsubst $(SRC_DIR)/%.cpp,$(BUILD_DIR)/%.o,$<)' $< -MF $@

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

