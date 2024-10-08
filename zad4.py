import asyncio


async def main() -> None:
    await asyncio.sleep(1)
    print(1)
    await asyncio.sleep(1)
    print(2)
    await asyncio.sleep(1)
    print(3)
    await asyncio.sleep(1)
    print(4)
    await asyncio.sleep(1)
    print(5)


if __name__ == "__main__":
        loop = asyncio.new_event_loop()
        asyncio.set_event_loop(loop)

        task = loop.create_task(main())  # 2

        try:
            loop.run_until_complete(task)  # 3
        except KeyboardInterrupt:  # 4
            print("Closing the app")

            tasks = asyncio.all_tasks(loop=loop)  # 5
            for task_ in tasks:
                task_.cancel()

            group = asyncio.gather(*tasks, return_exceptions=True)
            loop.run_until_complete(group)
            loop.close()