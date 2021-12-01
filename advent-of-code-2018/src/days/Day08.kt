package days

class Day08(rawInput: List<String>) : Day {
    private val input = rawInput[0].split(" ").map { it.toInt() }
    private val rootNode = Node.of(input.iterator())
    override fun part1() {
        println(rootNode.metadataSum)
    }

    override fun part2() {
        println(rootNode.nodeValue)
    }

    class Node(children: List<Node>, metadata: List<Int>) {

        companion object {
            fun of(values: Iterator<Int>): Node {
                val childNodesQuantity = values.next()
                val metadataQuantity = values.next()
                val children = (0 until childNodesQuantity).map { Node.of(values) }
                val metadata = (0 until metadataQuantity).map { values.next() }.toList()
                return Node(children, metadata)
            }
        }

        val metadataSum: Int = metadata.sum() + children.sumBy { it.metadataSum }
        val nodeValue: Int =
            if (children.isEmpty()) metadata.sum()
            else metadata.sumBy { children.getOrNull(it - 1)?.nodeValue ?: 0 }
    }
}