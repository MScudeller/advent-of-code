package days

class Day10(rawInput: List<String>) : Day {
    private val universe = Universe(rawInput.map { Light.of(it) })
    private var time = 0

    override fun part1() {
        run()
        universe.printAt(time)
    }

    override fun part2() {
        println(time)
    }

    private fun run() {
        time
        var previousArea: Long
        var area = universe.areaAt(time).area
        do {
            previousArea = area
            time++
            area = universe.areaAt(time).area
        } while (area < previousArea)
        time--
    }

    class Universe(private val lights: List<Light>) {
        fun areaAt(time: Int): Area {
            val positions = lights.map { it.positionAt(time) }
            val minX = positions.minBy { it.x }!!.x
            val minY = positions.minBy { it.y }!!.y
            val maxX = positions.maxBy { it.x }!!.x
            val maxY = positions.maxBy { it.x }!!.y

            val min = Position(minX, minY)
            val max = Position(maxX, maxY)
            return Area(min, max)
        }

        fun printAt(time: Int) {
            val areaAtTime = areaAt(time)
            val matrix = Array(areaAtTime.height + 1) { Array(areaAtTime.width) { '.' } }
            val mapped = lights.map {
                it.positionAt(time).adjust(-areaAtTime.min.x, -areaAtTime.min.y)
            }
            mapped.forEach {
                matrix[it.y][it.x] = '#'
            }

            matrix.forEach { line ->
                line.forEach { print(it) }
                println()
            }
        }
    }

    class Light(private val initial: Position, private val xSpeed: Int, private val ySpeed: Int) {
        companion object {
            private val regex = """position=<\s*(-?\d*),\s*(-?\d*)> velocity=<\s*(-?\d*),\s*(-?\d*)>""".toRegex()
            fun of(input: String): Light {
                val (x, y, xSpeed, ySpeed) = regex.find(input)!!.destructured
                return Light(Position(x.toInt(), y.toInt()), xSpeed.toInt(), ySpeed.toInt())
            }
        }

        fun positionAt(time: Int): Position = Position(initial.x + time * xSpeed, initial.y + time * ySpeed)
    }

    class Position(val x: Int, val y: Int) {
        fun adjust(w: Int, h: Int) = Position(x + w, y + h)
    }

    class Area(val min: Position, max: Position) {
        val width = (max.x - min.x) + 1
        val height = (max.y - min.y) + 1
        val area = width.toLong() * height.toLong()
    }
}