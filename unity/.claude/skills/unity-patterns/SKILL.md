---
name: unity-patterns
description: Unity architecture and performance patterns. Use when implementing Observer, State, Object Pooling, MVC/MVP patterns, or optimizing Unity code.
---

# Unity Patterns

## When to Use

- Implementing event-driven communication between systems (Observer pattern).
- Building FSMs for AI, game states, or UI flows (State pattern).
- Optimizing frequent instantiation like bullets or particles (Object Pooling).
- Structuring UI architecture (MVC/MVP).
- Performance optimization (caching, allocations, Jobs).

## Architecture Patterns

### Observer Pattern
Decouple systems using events. Prefer `System.Action` or UnityEvents.

```csharp
[CreateAssetMenu]
public class GameEvent : ScriptableObject
{
    private readonly List<Action> _listeners = new();
    public void Raise() => _listeners.ForEach(l => l?.Invoke());
    public void Register(Action listener) => _listeners.Add(listener);
    public void Unregister(Action listener) => _listeners.Remove(listener);
}
```

Guide: https://learn.unity.com/tutorial/create-modular-and-maintainable-code-with-the-observer-pattern

### State Pattern
Encapsulate state-specific behavior in state classes.

```csharp
public interface IState { void Enter(); void Execute(); void Exit(); }
public class StateMachine
{
    private IState _currentState;
    public void ChangeState(IState newState)
    {
        _currentState?.Exit();
        _currentState = newState;
        _currentState?.Enter();
    }
    public void Update() => _currentState?.Execute();
}
```

Guide: https://learn.unity.com/tutorial/develop-a-modular-flexible-codebase-with-the-state-programming-pattern-1

### Object Pooling
Reuse objects instead of instantiate/destroy.

```csharp
public class ObjectPool<T> where T : Component
{
    private readonly Queue<T> _pool = new();
    private readonly T _prefab;
    public T Get() => _pool.Count > 0 ? _pool.Dequeue() : Object.Instantiate(_prefab);
    public void Return(T obj) { obj.gameObject.SetActive(false); _pool.Enqueue(obj); }
}
```

Guide: https://learn.unity.com/tutorial/use-object-pooling-to-boost-performance-of-c-scripts-in-unity

### MVC/MVP
Separate UI from game logic.

Guide: https://learn.unity.com/tutorial/build-a-modular-codebase-with-mvc-and-mvp-programming-patterns-1

## Performance Tips

- Cache GetComponent results
- Avoid allocations in Update (use object pooling, StringBuilder)
- Use Jobs and Burst for CPU-intensive work
- Profile with Unity Profiler before optimizing

Guide: https://docs.unity3d.com/Manual/best-practice-guides.html
