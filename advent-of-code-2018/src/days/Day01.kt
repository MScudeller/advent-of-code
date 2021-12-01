package days

class Day01(private val rawInput: List<String>) : Day {
    val input = rawInput.map { it.trim().toInt() }

    override fun part1() {
        val fold = rawInput.fold(0) { acc, t -> acc + t.trim().toInt() }
        println(fold)
    }

    override fun part2() {
        val reachedList = mutableSetOf(0)
        var currentSum = 0
        var index = 0
        while (!reachedList.add(currentSum)) {
            currentSum += input[index % input.size]
            index++
        }
        println(currentSum)
    }

    fun part2otherWay() {
        val frequencies = mutableSetOf(0)
        var sum = 0
        input.toInfiniteSequence()
                .map {
                    sum += it
                    sum
                }
                .first { !frequencies.add(it) }
    }

    private fun <T> List<T>.toInfiniteSequence(): Sequence<T> = sequence {
        if (this@toInfiniteSequence.isEmpty()) {
            return@sequence
        }
        while (true) {
            yieldAll(this@toInfiniteSequence)
        }
    }
}