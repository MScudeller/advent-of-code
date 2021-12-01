package days

class Day02(private val input: List<String>) : Day {
    override fun part1() {
        val pair = input
            .map { s -> checkDuplicate(s) }
            .fold(Pair(0, 0)) { acc, pair ->
                val first = acc.first + if (pair.first) 1 else 0
                val second = acc.second + if (pair.second) 1 else 0
                Pair(first, second)
            }
        val final = pair.first * pair.second
        println(final)
    }

    private fun checkDuplicate(inp: String): Pair<Boolean, Boolean> {
        val sorted = inp.toList().sortedBy { c -> c }
        var first = 0
        var last: Int
        var double = false
        var triplet = false
        do {
            val character = sorted[first]
            last = sorted.lastIndexOf(character)
            if (last == first + 1)
                double = true
            else if (last == first + 2)
                triplet = true
            first = last + 1
        } while (first != sorted.size)
        return Pair(double, triplet)
    }

    override fun part2() {
        val pair = findIDs(input)
        for (i in 0 until pair.first.length){
            if (pair.first[i] == pair.second[i]) {
                print(pair.first[i])
            }
        }
        println()
    }

    private fun findIDs(inputList: List<String>): Pair<String, String> {
        for (i in 0 until inputList.size - 1) {
            val last = inputList.drop(i + 1)
            for (j in 0 until last.size) {
                val first = inputList[i]
                val second = last[j]
                if (compareChars(first, second)) {
                    return Pair(first, second)
                }
            }
        }
        throw Exception("wut?")
    }

    private fun compareChars(first: String, second: String): Boolean {
        if (first.length != second.length || first.isEmpty() || second.isEmpty() || first == second)
            return false
        val maxDifferentCharacters = 1
        var strikeCount = 0
        for (i in 0 until first.length) {
            if (first[i] != second[i])
                strikeCount++
            if (strikeCount > maxDifferentCharacters)
                return false
        }
        return true
    }
}
