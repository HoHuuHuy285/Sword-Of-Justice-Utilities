window.stopClaim = false; // Gõ 'window.stopClaim = true' để dừng

(async () => {
  const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

  // 1. MUTATION OBSERVER (Bẫy đóng Popup)
  const targetNode =
    document.getElementById("root") ||
    document.querySelector(".e3-page") ||
    document.body;

  const observer = new MutationObserver(() => {
    const closeBtn = document.querySelector(".e3-popup-close");
    if (closeBtn) closeBtn.click();
  });
  observer.observe(targetNode, { childList: true, subtree: true });

  console.log("🟢 [Super-Fast] Kích hoạt vòng lặp an toàn...");

  while (!window.stopClaim) {
    console.log("Looping...");
    const unclaimedMissions = document.querySelector(
      '[class*="--completedUnclaimed"]',
    );

    if (unclaimedMissions) {
      const button = unclaimedMissions.querySelector(
        '[class*="-mission-action"], .e3-game-button',
      );

      if (button && !button.disabled) {
        const title =
          unclaimedMissions.querySelector("h3")?.innerText || "Nhiệm vụ";
        button.click();
        console.log(`[Super-Fast] 🎯 Đã bấm: "${title}"`);

        // Nghỉ 500ms sau khi bấm để web xử lý API gửi đi
        await sleep(500);
      }
    }

    // 🛡️ ĐIỂM QUAN TRỌNG NHẤT: Bắt buộc sleep ở cuối vòng lặp
    // Giúp bảo vệ CPU không bị kẹt Tight Loop 0ms kể cả khi button bị disabled
    await sleep(100);
  }

  observer.disconnect();
  console.log("🔴 [Super-Fast] Đã dừng script!");
})();
