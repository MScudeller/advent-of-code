fun main(args: Array<String>) {
    val dayFactory = DayFactory()
    val day = 10
    val puzzle = dayFactory.buildDay(day)
    println("results for day $day")
    puzzle.part1()
    puzzle.part2()
}