package days

class Day03(input: List<String>) : Day {
    private val claims = input.map { s -> buildClaim(s) }

    override fun part1() {
        val fabric = Array(1500) { Array(1500) { 0 } }
        claims.flatMap { c -> c.rectangle.allVertexes }.forEach { v -> fabric[v.x][v.y]++ }
        val foo = fabric.flatten().filter { i -> i >= 2 }
        val result = foo.size
        println(result)
    }

    override fun part2() {
        for (claim in claims) {
            if (claims.filterNot { c -> c.id == claim.id }.flatMap { c -> c.rectangle.allVertexes }.toHashSet().intersect(claim.rectangle.allVertexes).isEmpty()) {
                println(claim.id)
            }
        }
    }

    private fun buildClaim(value: String): Claim {
        val regex = Regex("(#[0-9]*) @ ([0-9]*),([0-9]*): ([0-9]*)x([0-9]*)")
        val results = regex.matchEntire(value) ?: throw IllegalArgumentException(value)
        val id = results.groupValues[1]
        val x = results.groupValues[2].toInt()
        val y = results.groupValues[3].toInt()
        val w = results.groupValues[4].toInt()
        val h = results.groupValues[5].toInt()
        val topLeftVertex = Vertex(x, y)
        val bottomRightVertex = Vertex(x + w - 1, y + h - 1)
        val rect = Rectangle(topLeftVertex, bottomRightVertex)
        return Claim(id, rect)
    }

    class Claim(val id: String, val rectangle: Rectangle) {
        companion object {
            private val regex = Regex("""(#\d*) @ (\d*),(\d*): (\d*)x(\d*)""")

            fun parse(input: String): Claim =
                    regex.find(input)?.let {
                        val (id, x, y, w, h) = it.destructured
                        val topLeftVertex = Vertex(x.toInt(), y.toInt())
                        val bottomRightVertex = Vertex(x.toInt() + w.toInt() - 1, y.toInt() + h.toInt() - 1)
                        val rect = Rectangle(topLeftVertex, bottomRightVertex)
                        Claim(id, rect)
                    } ?: throw IllegalArgumentException("Cannot parse $input")

        }
    }

    class Rectangle(
            private val topLeftVertex: Vertex,
            private val bottomRightVertex: Vertex
    ) {
        val allVertexes: Set<Vertex>
            get() {
                val vertexes = HashSet<Vertex>()
                for (i in topLeftVertex.x..bottomRightVertex.x) {
                    for (j in topLeftVertex.y..bottomRightVertex.y) {
                        vertexes.add(Vertex(i, j))
                    }
                }
                return vertexes
            }
    }

    class Vertex(val x: Int, val y: Int) {
        override fun equals(other: Any?): Boolean {
            if (this === other) return true
            if (javaClass != other?.javaClass) return false

            other as Vertex

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

