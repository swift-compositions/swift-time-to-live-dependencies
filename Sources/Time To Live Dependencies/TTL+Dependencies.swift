public import Clocks_Dependencies
import Dependencies
public import Time_Primitive
public import Time_To_Live

extension TTL where Instant == Clock.`Any`<Time_Primitive.Duration>.Instant {

    public func isExpired() -> Bool {
        @Dependency(\.clock) var clock
        return self.isExpired(at: clock.now)
    }
}
