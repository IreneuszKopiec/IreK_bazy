import asyncio


async def main() -> None:
    await asyncio.sleep(3)
    print("Hello")
    await dwa()

async def dwa() -> None:
    await asyncio.sleep(1)
    print("world")

if __name__ == "__main__":
    asyncio.run(main())

