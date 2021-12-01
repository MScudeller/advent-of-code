package days

class Day05(input: List<String>) : Day {
    val polymer = input[0]
    val reactedPolymer:String by lazy { reactPolymer(polymer) }

    override fun part1() {
        println(reactedPolymer.length)
    }

    private fun reactPolymer(polymer: String): String {
        var internalPolymer = polymer
        var index = 0
        do {
            val c1 = internalPolymer[index]
            val c2 = internalPolymer[index + 1]
            if (c1 != c2 && c1.toLowerCase() == c2.toLowerCase()) {
                internalPolymer = internalPolymer.removeRange(index, index + 2)
                if (index > 0) {
                    index--
                }
            } else {
                index++
            }
        } while (index != internalPolymer.lastIndex)
        return internalPolymer
    }

    override fun part2() {
        val list = mutableListOf<Int>()
        for (c in reactedPolymer.toLowerCase().toSortedSet()) {
            var reacted = reactedPolymer
            reacted = reacted.replace(c.toString(), "")
            reacted = reacted.replace(c.toUpperCase().toString(), "")
            reacted = reactPolymer(reacted)
            list.add(reacted.length)
        }
        println(list.min())
    }
}