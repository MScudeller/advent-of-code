package days

import java.time.LocalDate
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter
import java.util.*

class Day04(input: List<String>) : Day {
    private val entries = input.map { s -> buildEntry(s) }.sortedBy { entry -> entry.time }
    private val guards: Set<Guard>

    init {
        val mutableGuards = mutableSetOf<Guard>()
        var lastGuardId: String? = null
        entries.forEach { entry ->
            when {
                entry.message.startsWith("Guard") -> {
                    val regex = Regex("Guard #(\\d*) begins shift")
                    val results = regex.matchEntire(entry.message) ?: throw IllegalArgumentException()
                    val id = results.groupValues[1]
                    lastGuardId = id
                    mutableGuards.add(Guard(id))
                }
                entry.message.startsWith("wakes") -> {
                    setGuardAsleep(mutableGuards.single { g -> g.id == lastGuardId }, entry.time, false)
                }
                entry.message.startsWith("falls") -> {
                    setGuardAsleep(mutableGuards.single { g -> g.id == lastGuardId }, entry.time, true)
                }
            }
        }
        guards = mutableGuards
    }

    private fun buildEntry(value: String): Entry {
        val regex = Regex("\\[(.*)] (.*)")
        val results = regex.matchEntire(value) ?: throw IllegalArgumentException(value)
        val stringDate = results.groupValues[1]
        val formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")
        val date = LocalDateTime.parse(stringDate, formatter)
        val message = results.groupValues[2]
        return Entry(date, message)
    }

    private fun setGuardAsleep(guard: Guard, dateTime: LocalDateTime, asleep: Boolean) {
        val date = LocalDate.of(dateTime.year, dateTime.month, dateTime.dayOfMonth)
        val minute = dateTime.minute
        if (guard.map[date] == null) {
            guard.map[date] = MutableList(60) { false }
        }
        for (i in minute until guard.map[date]!!.size) {
            guard.map[date]!![i] = asleep
        }
    }

    override fun part1() {
        val guard = guards.reduce { acc, guard -> if (acc.mostSleptMinuteTimes > guard.hoursAsleep) acc else guard }
        val result = guard.id.toInt() * guard.mostSleptMinute
        println(result)
    }

    override fun part2() {
        val guard = guards.reduce { acc, guard -> if (acc.mostSleptMinuteTimes > guard.mostSleptMinuteTimes) acc else guard }
        val result = guard.id.toInt() * guard.mostSleptMinute
        println(result)
    }

    class Entry(val time: LocalDateTime, val message: String)

    class Guard(val id: String) {
        val map = HashMap<LocalDate, MutableList<Boolean>>()

        val hoursAsleep: Int by lazy { map.flatMap { m -> m.value }.filter { b -> b }.count() }

        val mostSleptMinute: Int by lazy {
            val l = map.values.fold(MutableList(60){0}) { acc, v -> v.forEachIndexed { index, b -> acc[index] += (if (b) 1 else 0) }; acc}
            l.indexOf(l.max())
        }

        val mostSleptMinuteTimes: Int by lazy {
            val l = map.values.fold(MutableList(60){0}) { acc, v -> v.forEachIndexed { index, b -> acc[index] += (if (b) 1 else 0) }; acc}
            l.max()!!
        }

        fun foo() {

        }

        override fun equals(other: Any?): Boolean {
            if (this === other) return true
            if (javaClass != other?.javaClass) return false

            other as Guard

            if (id != other.id) return false

            return true
        }

        override fun hashCode(): Int {
            return id.hashCode()
        }

    }
}