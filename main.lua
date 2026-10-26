local player = {
    hp = 30,
    max_hp = 30,
    gold = 0,
    inventory = {}
}

local function print_status()
    print("\n-------------------------")
    print("HP: " .. player.hp .. "/" .. player.max_hp .. " | Gold: " .. player.gold)
    print("-------------------------")
end

local function fight()
    local monster_hp = math.random(10, 20)
    print("\nA wild goblin appeared!")

    while monster_hp > 0 and player.hp > 0 do
        print("\nGoblin HP: " .. monster_hp)
        print("1. Attack")
        print("2. Run away")
        io.write("> ")
        local choice = io.read()

        if choice == "1" then
            -- player hits
            local damage = math.random(4, 8)
            monster_hp = monster_hp - damage
            print("You hit the goblin for " .. damage .. " damage.")

            -- goblin hits back if alive
            if monster_hp > 0 then
                local monster_dmg = math.random(2, 5)
                player.hp = player.hp - monster_dmg
                print("The goblin hit you back for " .. monster_dmg .. " damage.")
            end
        elseif choice == "2" then
            print("You ran back to safety!")
            return
        else
            print("Invalid choice, lost your turn!")
        end
    end

    if player.hp > 0 then
        local gold_drop = math.random(5, 15)
        player.gold = player.gold + gold_drop
        print("\nYou defeated the goblin! Found " .. gold_drop .. " gold.")
    else
        print("\nYou were defeated...")
    end
end

local function shop()
    print("\n--- Village Shop ---")
    print("1. Health Potion (10 Gold) - Heals 15 HP")
    print("2. Leave shop")
    io.write("> ")
    local choice = io.read()

    if choice == "1" then
        if player.gold >= 10 then
            player.gold = player.gold - 10
            player.hp = math.min(player.max_hp, player.hp + 15)
            print("Bought a potion! Healed up.")
        else
            print("Not enough gold!")
        end
    end
end

-- main loop
math.randomseed(os.time())
print("Welcome to my dungeon game!")

while player.hp > 0 do
    print_status()
    print("What do you want to do?")
    print("1. Explore dungeon")
    print("2. Visit shop")
    print("3. Quit game")
    io.write("> ")

    local input = io.read()

    if input == "1" then
        fight()
    elseif input == "2" then
        shop()
    elseif input == "3" then
        print("Thanks for playing")
        break
    else
        print("Unknown command.")
    end
end
