package days

import kotlin.math.abs

class Day06(input: List<String>) : Day {

    private val coordinates = input.map { it ->
        val regex = Regex("(\\d*), (\\d*)")
        val results = regex.matchEntire(it) ?: throw IllegalArgumentException()
        Coordinate(results.groupValues[1].toInt(), results.groupValues[2].toInt())
    }

    override fun part1() {
        val maxCoordinate = coordinates.fold(Pair(0, 0)) { acc, coordinate ->
            Pair(
                    if (coordinate.x > acc.first) coordinate.x else acc.first,
                    if (coordinate.y > acc.first) coordinate.y else acc.second)
        }
        val grid = MutableList(maxCoordinate.first + 5) { MutableList<Coordinate?>(maxCoordinate.second + 5) { null } }
        for (i in grid.indices) {
            for (j in grid[i].indices) {
                var clash = false
                for (c in coordinates) {
                    val previousDistance = grid[i][j]?.distanceTo(i, j) ?: Int.MAX_VALUE
                    val distanceToC = c.distanceTo(i, j)
                    if (previousDistance > distanceToC) {
                        grid[i][j] = c
                        clash = false
                    } else if (previousDistance == distanceToC) {
                        clash = true
                    }
                }
                if (clash) {
                    grid[i][j] = null
                }
            }
        }

        val set = mutableSetOf<Coordinate?>()
        for (i in grid.indices) {
            set.add(grid[i][0])
            set.add(grid[i][grid.indices.last])
        }
        for (i in grid[0].indices) {
            set.add(grid[0][i])
            set.add(grid[grid[0].indices.last][i])
        }

        set.remove(null)

        val foo: List<Coordinate?> = grid.flatten().filterNot { coordinate -> set.contains(coordinate) }
        val map = mutableMapOf<Coordinate?, Int>()
        for (coordinate in foo) {
            if (coordinate == null) continue
            val i = map[coordinate]
            map[coordinate] = if (i == null) 1 else i + 1
        }
        val largest = map.maxBy { m -> m.value }
        println(largest?.value)
    }

    override fun part2() {
        val maxCoordinate = coordinates.fold(Pair(0, 0)) { acc, coordinate ->
            Pair(
                    if (coordinate.x > acc.first) coordinate.x else acc.first,
                    if (coordinate.x > acc.first) coordinate.x else acc.first)
        }
        val grid = MutableList(maxCoordinate.first + 5) { MutableList(maxCoordinate.second + 5) { 0 } }

        for (i in grid.indices) {
            for (j in grid[i].indices) {
                for (c in coordinates) {
                    val distanceToC = c.distanceTo(i, j)
                    grid[i][j] = grid[i][j] + distanceToC
                }
            }
        }
        val count = grid.flatten().count { i -> i < 10000 }
        println(count)
    }

    class Coordinate(val x: Int, val y: Int) {
        fun distanceTo(p: Int, q: Int) = abs(x - p) + abs(y - q)
        override fun equals(other: Any?): Boolean {
            if (this === other) return true
            if (javaClass != other?.javaClass) return false

            other as Coordinate

            if (x != other.x) return false
            if (y != other.y) return false

            return true
        }

        override fun hashCode(): Int {
            var result = x
            result = 31 * result + y
            return result
        }

    }
}