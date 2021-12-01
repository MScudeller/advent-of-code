package days

class Day07(input: List<String>) : Day {
    private val graph: List<Step>

    init {
        graph = buildGraph(input)
    }

    private fun buildGraph(input: List<String>): List<Step> {
        val set = mutableSetOf<Step>()
        val regex = Regex("Step (.) must be finished before step (.) can begin.")
        for (string in input) {
            val results = regex.matchEntire(string) ?: throw IllegalArgumentException()
            val previousChar = results.groupValues[1].first()
            val stepChar = results.groupValues[2].first()
            val previous = set.firstOrNull { step -> step.id == previousChar } ?: Step(previousChar)
            set.add(previous)
            val step = set.firstOrNull { step -> step.id == stepChar } ?: Step(stepChar)
            set.add(step)
            step.previous.add(previous)
            previous.next.add(step)
        }
        val list = set.toMutableList()
        list.sortBy { it.id }
        return list
    }

    override fun part1() {
        val done = mutableListOf<Step>()
        for (i in graph) {
            val step = graph.first { it.previous.all { step -> done.contains(step) } && !done.contains(it) }
            done.add(step)
            print(step.id)
        }
        println()
    }

    override fun part2() {
        val workers = List(5) { Worker(null, 0) }
        val done = mutableListOf<Step>()
        val inProgress = mutableListOf<Step>()
        var totalTime = 0
        do {
            for (worker in workers) {
                if (worker.step != null && worker.stepProgress == worker.step?.timeLength) {
                    done.add(worker.step!!)
                    inProgress.remove(worker.step!!)
                    worker.step = null
                }
            }

            for (worker in workers) {
                if (worker.step == null) {
                    worker.step = graph.firstOrNull { it.previous.all { step -> done.contains(step) } && !done.contains(it) && !inProgress.contains(it) }
                    worker.stepProgress = 0
                    if (worker.step != null) {
                        inProgress.add(worker.step!!)
                    }
                }
                worker.stepProgress++
            }

//            print("$totalTime")
//            for (i in workers)
//                print("- ${i.step?.id ?: "."}")
//            println("- ${done.size}")
            totalTime++
        } while (done.size < graph.size)
        println(totalTime - 1)
    }

    class Step(val id: Char) {
        val timeLength = id.toInt() - 4
        val previous = mutableListOf<Step>()
        val next = mutableListOf<Step>()

        override fun equals(other: Any?): Boolean {
            if (this === other) return true
            if (javaClass != other?.javaClass) return false

            other as Step

            if (id != other.id) return false

            return true
        }

        override fun hashCode(): Int {
            return id.hashCode()
        }

    }

    class Worker(var step: Step?, var stepProgress: Int)
}